import Config, only: [config: 2, import_config: 1]

import_config "test.exs"

config :adam, env: [dev: true]
config :logger, level: :debug
