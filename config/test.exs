import Config, only: [config: 2, config: 3, import_config: 1]

alias AdamWeb, as: Web

alias Web.{Endpoint, Proxy}

import_config "prod.exs"

config :adam, env: [test: true]

config :adam, Endpoint,
  http: [port: 4_012],
  https: [port: 4_013],
  url: [host: "localhost", path: "/", port: 4_003, scheme: "https"]

config :adam, Proxy,
  http: [port: 4_002],
  https: [port: 4_003],
  url: [host: "localhost", path: "/", port: 4_003, scheme: "https"]

config :logger, level: :warning
config :phoenix, :plug_init_mode, :runtime
