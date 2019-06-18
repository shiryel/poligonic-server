defmodule Poligonic.Repo do
  use Ecto.Repo,
    otp_app: :poligonic,
    adapter: Ecto.Adapters.Postgres
end
