defmodule PoligonicWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation
  alias Poligonic.Repo

  # TODO: Implementar usuarios authenticados por facebook e googleplay
  @desc "Informaçoes de usuario basico"
  object :user do
    field :id, :integer
    field :username, :string
    field :email, :string
    field :player_maps, list_of(:player_map) do
      resolve fn
        user, _, _ ->
          q = Ecto.assoc(user, :player_maps)
          {:ok, Repo.all(q)}
      end
    end

    field :master_poligons, list_of(:master_poligon) do
      resolve fn
        user, _, _ ->
          q = Ecto.assoc(user, :master_poligons)
          {:ok, Repo.all(q)}
      end
    end
  end

  object :result_user do
    field :user, :user
    field :errors, list_of(:error)
  end

end
