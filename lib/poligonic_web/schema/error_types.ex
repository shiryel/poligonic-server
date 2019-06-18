defmodule PoligonicWeb.Schema.ErrorTypes do
  use Absinthe.Schema.Notation

  object :error do
    field :key, non_null(:string)
    field :message, non_null(:string)
  end

end
