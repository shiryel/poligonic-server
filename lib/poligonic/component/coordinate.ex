defmodule Poligonic.Component.Coordinate do
  use Ecto.Schema

  @moduledoc """
  Coordenada basica do sistema
  Nao armazena a informaçao z, uma vez que nem todas coordenadas precisam de superposiçao
  """

  embedded_schema do
    field :x, :float
    field :y, :float
  end
end
