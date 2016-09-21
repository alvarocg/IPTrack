# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :iptrack,
  ecto_repos: [Iptrack.Repo]

# Configures the endpoint
config :iptrack, Iptrack.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5tUnwtTV4f3+VauBVrgqDNUbsWuEZ8fvQPbs5CQewHvA+cgqVxl0EfpKQt8ief1B",
  render_errors: [view: Iptrack.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Iptrack.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
