defmodule Poligonic.Component.PlayerMap do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poligonic.{Component, Authentication}

  @moduledoc """
  Mapa do jogador

  É relacionado com varios poligonos principais e posicionado em seu devido eixo
    pela tabela :player_maps_mater_poligons (many_to_many)
  """

  schema "player_maps" do
    field :name, :string
    belongs_to :user, Authentication.User

    # MANY_TO_MANY:
    has_many :player_maps_master_poligons, Component.PlayerMapsMasterPoligons
    has_many :master_poligons, through: [:player_maps_master_poligons, :master_poligon]
  end

  @spec changeset(
          Poligonic.Component.PlayerMap.t(),
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = player_map, attrs) do
    player_map
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
