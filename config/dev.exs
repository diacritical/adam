import Config, only: [config: 2, config: 3, import_config: 1]

alias AdamWeb, as: Web

alias Web.Endpoint

import_config "test.exs"

config :adam, env: [dev: true]

config :adam, Endpoint,
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  http: [port: 4_004],
  https: [port: 4_005],
  url: [host: "localhost", path: "/", port: 4_005, scheme: "https"]

config :logger, level: :debug
config :phoenix, :stacktrace_depth, 32
