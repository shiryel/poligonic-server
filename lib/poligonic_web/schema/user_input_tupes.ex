defmodule PoligonicWeb.Schema.UserInputTypes do
  use Absinthe.Schema.Notation

  input_object :input_user do
    field :username, non_null(:string)
    field :email, non_null(:string)
    field :password, non_null(:string)
  end

  input_object :input_login_user do
    field :username, non_null(:string)
    field :password, non_null(:string)
  end
end
