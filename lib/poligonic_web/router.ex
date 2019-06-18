defmodule PoligonicWeb.Router do
  use PoligonicWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: PoligonicWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: PoligonicWeb.Schema,
      interface: :simple
  end
end
