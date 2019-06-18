defmodule Poligonic.Component.Hitbox do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poligonic.Component

  @moduledoc """
  BEHAVIOR

  Permique que um poligono tenha uma hitbox
  """

  schema "hitboxs" do
    field :life, :integer
    field :godmode, :boolean, default: false
    embeds_many :routes, Component.Coordinate

    belongs_to :poligon, Component.Poligon # Copose
  end

  @spec changeset(
          Poligonic.Component.Hitbox.t(),
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = hitbox, attrs) do
    hitbox
    |> cast(attrs, [:colision_route, :life, :godmode])
    |> validate_required([:colision_route, :life])
  end
end
