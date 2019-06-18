defmodule Poligonic.Component.Cannon do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poligonic.Component

  @moduledoc """
  BEHAVIOR

  Permite que um poligono assuma o comportamento de um canhao
  """

  schema "cannons" do
    field :fire_rate, :integer
    field :out_x, :float
    field :out_y, :float
    field :out_invert, :boolean, default: false

    belongs_to :poligon, Component.Poligon # Behavior
    many_to_many :bullets, Component.Bullet, join_through: "cannons_bullets"
  end

  @spec changeset(
          Poligonic.Component.Cannon.t(),
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = cannon, attrs) do
    cannon
    |> cast(attrs, [:fire_rate, :out_x, :out_y, :out_invert])
    |> validate_required([:fire_rate, :out_x, :out_y])
  end
end
