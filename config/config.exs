# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :outcomes,
  ecto_repos: [Outcomes.Repo]

# Configures the endpoint
config :outcomes, Outcomes.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "n0Vblc4L+f46aXV/fZpp9cXZy3XYm0rVgU7B2ejXaGw031WHKkunPa9tMkfaVYb3",
  render_errors: [view: Outcomes.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Outcomes.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :guardian, Guardian,
  issuer: "PhoenixGuardian.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: PhoenixGuardian.GuardianSerializer,
  secret_key: to_string(Mix.env),
  hooks: GuardianDb,
  permissions: %{
    default: [:read, :write],
    admin: [:dashboard, :reconcile]
  }
