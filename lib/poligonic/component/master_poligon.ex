defmodule Poligonic.Component.MasterPoligon do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poligonic.{Authentication, Component}

  @moduledoc """
  Poligono raiz do jogo

  Um jogador pode criar um poligono raiz (aka mestre) e vender ele na loja para
    outros players utilizarem em seus mapas, porem mantendo as info do criador

  :role define como o poligono raiz deve se comportar no jogo
  """

  schema "master_poligons" do
    field :name, :string
    field :role, :string

    belongs_to :user, Authentication.User
    has_many :poligons, Component.Poligon # Composed of

    # MANY_TO_MANY:
    has_many :player_maps_master_poligons, Component.PlayerMapsMasterPoligons
    has_many :player_maps, through: [:player_maps_master_poligons, :player_map]
  end

  @spec changeset(
          Poligonic.Component.MasterPoligon.t(),
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = master_poligon, attrs) do
    master_poligon
    |> cast(attrs, [:name, :role])
    |> validate_required([:name, :role])
  end
end
