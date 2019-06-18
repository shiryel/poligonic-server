defmodule Poligonic.Component.Poligon do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poligonic.{Component}

  @moduledoc """
  Poligono basico

  Se constitui de varios [:poligon_structs]
  Pode se comportar como [:hitboxs, :cannon, :bullet]

  É utilizado pelo [:master_poligons] para gerar o poligono principal

  :role define como o poligono deve se comportar no poligono principal
  """

  schema "poligons" do
    field :z, :integer
    field :role, :string

    belongs_to :master_poligon, Component.MasterPoligon
    has_many :poligon_structs, Component.PoligonStruct # Compositioned of
    has_many :hitboxs, Component.Hitbox # Compositioned of

    has_one :bullet, Component.Bullet # Behavior
    has_one :cannon, Component.Cannon # Behavior

    timestamps()
  end

  @spec changeset(
          Poligonic.Component.Poligon.t(),
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = poligon, attrs) do
    poligon
    |> cast(attrs, [:name, :z, :role])
    |> validate_required([:name, :z, :role])
  end

end
