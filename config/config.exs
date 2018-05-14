# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phx_in_place_demo,
  ecto_repos: [PhxInPlaceDemo.Repo]

# Configures the endpoint
config :phx_in_place_demo, PhxInPlaceDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RWm68U7zQLpCiUGd9MGPSH67wTZxKkckRFAnYWLViNgbcr5BFyNBvNVv4S/XmHet",
  render_errors: [view: PhxInPlaceDemoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhxInPlaceDemo.PubSub,
           adapter: Phoenix.PubSub.PG2]

 config :phx_in_place,
  repo: PhxInPlaceDemo.Repo,
  endpoint: PhxInPlaceDemoWeb.Endpoint

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :number,
  currency: [
    unit: "$",
    precision: 2,
    delimiter: ",",
    separator: ".",
    format: "%u %n",           # "$ 30.00"
    negative_format: "(%u %n)" # "($ 30.00)"
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
