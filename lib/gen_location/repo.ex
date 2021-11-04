defmodule GenLocation.Repo do
  use Ecto.Repo,
    otp_app: :gen_location,
    adapter: Ecto.Adapters.Postgres
end
