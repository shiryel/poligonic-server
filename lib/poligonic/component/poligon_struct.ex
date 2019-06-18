defmodule Poligonic.Component.PoligonStruct do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poligonic.Component

  @moduledoc """
    Este module é o modulo principal dos poligonos do jogo
    Ele é construido no construtor de poligonos do jogo

    Ele ira compor:
    - Poligonos gerais (walls, background, hull)

    Que tambem podem se comportar como:
    - Canhoes [possibilidade de atirar bullets]
    - Bullets [possibilidade de dar dano]
    - Hitboxes [possibilidade de receber dano]

    Uma vez que o jogador pode customizar e compor cada um desses
  """

  schema "poligon_structs" do
    embeds_many :routes, Component.Coordinate
    field :color, :string
    field :z, :integer, default: 0

    belongs_to :poligon, Component.Poligon # Compose
  end

  @spec changeset(
          Poligonic.Component.PoligonStruct.t(),
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = poligon_struct, attrs) do
    poligon_struct
    |> cast(attrs, [:color, :z])
    |> cast_embed(:routes)
    |> validate_required([:routes, :color, :z])
  end

end
