defmodule Recemedtest.Repo do
  use Ecto.Repo,
    otp_app: :recemedtest,
    adapter: Ecto.Adapters.Postgres
end
