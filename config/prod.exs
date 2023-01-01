import Config, only: [config: 2, config: 3]

config :adam, env: [prod: true]
config :logger, level: :info
config :phoenix, :json_library, Jason
