defmodule Poligonic.Component.Bullet do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poligonic.Component

  @moduledoc """
  BEHAVIOR

  Permite que um poligono assuma o comportamento de uma bala
  """

  schema "bullets" do
    field :damage, :integer
    # TODO: add velocity
    field :trigger_x, :float, default: 0
    field :trigger_y, :float, default: 0
    belongs_to :poligon, Component.Poligon # Behavior
    many_to_many :cannons, Component.Cannon, join_through: "cannons_bullets"
  end

  @spec changeset(
          Poligonic.Component.Bullet.t(),
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = bullet, attrs) do
    bullet
    |> cast(attrs, [:damage, :trigger_x, :trigger_y])
    |> validate_required([:damage])
  end
end
