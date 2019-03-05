defmodule Websocketsample.Repo do
  use Ecto.Repo,
    otp_app: :websocketsample,
    adapter: Ecto.Adapters.Postgres
end
