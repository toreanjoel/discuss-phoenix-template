# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, DiscussWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: DiscussWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Discuss.PubSub,
  live_view: [signing_salt: "7c1ivKY/"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :discuss, Discuss.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

# There is also a :fs_poll backend that polls the filesystem and is available on all
# Operating Systems in case you don't want to install any dependency.
# You can configure the :backend in your config/config.exs:
config :phoenix_live_reload,
  backend: :fs_poll


config :phoenix_live_reload,
  dirs: [
    "priv/static",
    "priv/gettext",
    "lib",
  ],
  backend: :fs_poll,
  backend_opts: [
    interval: 1000
  ]

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "user", ignore_csrf_attack: true]}
  ]

# we need to config strat with tokens made - client id and secret
# this needs to come from ENV variable ideally
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "ebcde36409b914df5aff",
  client_secret: "9f75af7931c12cb1fa96d549191bd8b9335bd010"
