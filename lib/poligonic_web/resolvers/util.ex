defmodule PoligonicWeb.Resolvers.Util do
  alias Poligonic.Repo

  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
      use Absinthe.Schema.Notation
      alias PoligonicWeb.Resolvers.Util
    end
  end

  defmacro non_null(name, type) do
    quote do
      field unquote(name), non_null(unquote(type))
    end
  end

  @spec list_by_assoc(any()) :: (any(), any(), any() -> {:ok, any()})
  def list_by_assoc(assoc) do
    fn parent, _, _ ->
      q = Ecto.assoc(parent, assoc)
      {:ok, Repo.all(q)}
    end
  end

  @spec get_by_assoc(any()) :: (any(), any(), any() -> {:ok, any()})
  def get_by_assoc(assoc) do
    fn parent, _, _ ->
      q = Ecto.assoc(parent, assoc)
      {:ok, Repo.one(q)}
    end
  end
end
