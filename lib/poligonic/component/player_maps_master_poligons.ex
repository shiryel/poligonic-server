defmodule Poligonic.Component.PlayerMapsMasterPoligons do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poligonic.Component

  @moduledoc """
  Modulo para relacionar os mapas dos jogadores com os poligonos mestres

  Define onde cada um dos poligonos mestres ficam em relaçao ao ponto 0,0 da grid global
  """

  schema "player_maps_master_poligons" do
    field :x, :float
    field :y, :float
    field :z, :integer, default: 0
    belongs_to :master_poligon, Component.MasterPoligon
    belongs_to :player_map, Component.PlayerMap

    has_one :user, through: [:player_map, :user]
  end

  @spec changeset(
          Poligonic.Component.PlayerMapsMasterPoligons.t(),
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = map_poligon, attrs) do
    map_poligon
    |> cast(attrs, [:x, :y, :z])
    |> validate_required([:x, :y])
  end
end
