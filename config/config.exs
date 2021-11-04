# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gen_location,
  ecto_repos: [GenLocation.Repo]

# Configures the endpoint
config :gen_location, GenLocationWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3JWwMYBmWqU1qxQBxTQ3naLqw76ur4kEEKirPZYprVZfVaKdzuCvFUrcZkkOJzg2",
  render_errors: [view: GenLocationWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GenLocation.PubSub,
  live_view: [signing_salt: "iPs0QY9f"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
