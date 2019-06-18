defmodule PoligonicWeb.Schema do
  use Absinthe.Schema
  import Ecto.Query
  alias Poligonic.Repo

  alias Poligonic.{Component, Authentication}
  alias __MODULE__.Middleware

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end
  def middleware(middleware, _field, _object) do
    middleware
  end

  import_types __MODULE__.ComponentTypes
  import_types __MODULE__.ComponentInputTypes
  import_types __MODULE__.UserTypes
  import_types __MODULE__.UserInputTypes
  import_types __MODULE__.ErrorTypes

  query do
    field :users, list_of(:user) do
      arg :user_id, :integer
      resolve fn
        _, %{user_id: id}, _ ->
          {:ok, Authentication.get_user(id)}
        _, _, _ ->
          {:ok, Authentication.list_users()}
      end
    end

    field :player_maps, list_of(:player_map) do
      arg :user_id, :integer
      resolve fn
        _, %{user_id: id}, _ ->
          result = Component.PlayerMap
          |> where([p], p.user_id == ^id)
          |> Repo.all
          {:ok, result}
      end
    end

  end

  mutation do

#OLD:
# resolve fn
#   _, %{input: attrs}, _ ->
#     case Authentication.create_user(attrs) do
#       {:error, changeset} ->
#         {:error, changeset}
#       {:ok, user} ->
#         {:ok, %{user: user}}
#     end
#  end

    field :create_user, :result_user do
      arg :input, non_null(:input_user)
      resolve fn
        _, %{input: attrs}, _ ->
          with {:ok, user} <- Authentication.create_user(attrs) do
            {:ok, %{user: user}}
          end
      end
    end

    field :login_user, :result_user do
      arg :input, non_null(:input_login_user)
      resolve fn
        _, %{input: attrs}, _ ->
          user = Authentication.get_user(name: attrs.name)
          with {:ok, user} <- Authentication.login_by_username_and_pass(user, attrs.password) do
            {:ok, user: user}
          end
        end
    end

    field :create_player_map, :result_player_map do
      arg :input, non_null(:input_player_map)
      resolve fn
        _, %{input: attrs}, _ ->
          with {:ok, player_map} <- Component.create_player_map(attrs) do
            {:ok, player_map: player_map}
          end
        end
    end

    field :create_master_poligon, :result_master_poligon do
      arg :input, non_null(:input_poligon)
      resolve fn
        _, %{input: attrs}, _ ->
          with {:ok, master_poligon} <- Component.create_master_poligon(attrs) do
            {:ok, master_poligon: master_poligon}
          end
      end
    end

    field :create_poligon, :result_poligon do
      arg :input, non_null(:input_poligon)
      resolve fn
        _, %{input: attrs}, _ ->
          with {:ok, poligon} <- Component.create_poligon(attrs) do
            {:ok, poligon: poligon}
          end
      end
    end
  end

end
