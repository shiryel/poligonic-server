defmodule Poligonic.Authentication do
  import Ecto.Query, warn: false
  alias Poligonic.Repo
  alias __MODULE__.User

  def list_users() do
    Repo.all User
  end

  def get_user(id: user_id) do
    Repo.get User, user_id
  end
  def get_user(name: name) do
    User
    |> where(name: ^name)
    |> Repo.one()
  end

  @spec create_user(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  def create_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  ###############################################################
  ### LOGIN ###
  ###############################################################

  import Comeonin.Argon2, only: [checkpw: 2, dummy_checkpw: 0]
  alias Poligonic.Authentication.User

  @spec login_by_username_and_pass(Poligonic.Authentication.User.t(), any()) ::
          {:ok, nil} | {:error, :not_found | :unathorized, nil}
  def login_by_username_and_pass(%User{} = user, given_pass) do
    bd_user = Repo.get_by(User, username: user.username)

    cond do
      bd_user && checkpw(given_pass, bd_user.password_hash) ->
        {:ok, nil}
      bd_user ->
        {:error, :unathorized, nil}
      true ->
        dummy_checkpw()
        {:error, :not_found, nil}
    end
  end
end
