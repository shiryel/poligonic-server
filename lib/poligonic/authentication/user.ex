defmodule Poligonic.Authentication.User do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  Usuario do jogo, tambem chamado de player nas tabelas

  Possui varios [:master_poligons, :player_maps], e deve obrigar a autenticaçao
    dos mesmos

  Password é hashficado utilizando o Argon2 com o Comeonin
  """

  schema "users" do
    field :username, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()

    has_many :master_poligons, Poligonic.Component.MasterPoligon
    has_many :player_maps, Poligonic.Component.PlayerMap
    has_many :player_maps_master_poligons, through: [:player_maps, :player_maps_master_poligons]
  end

  @spec changeset(
          Poligonic.Authentication.User.t(),
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> unique_constraint(:username, name: :users_username_index)
    |> unique_constraint(:email, name: :users_email_index)
  end

  def registration_changeset(%__MODULE__{} = user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Argon2.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

  def update_changeset(%__MODULE__{} = user, attrs) do
    user = registration_changeset(user, attrs)
    %{user | action: :update}
  end

end
