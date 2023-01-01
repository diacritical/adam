import Config, only: [config: 2, config: 3]

alias Adam, as: Core
alias AdamWeb, as: Web

alias Core.PubSub
alias Web.Endpoint

config :adam, env: [prod: true]

config :adam, Endpoint,
  adapter: Bandit.PhoenixAdapter,
  force_ssl: [
    host: nil,
    rewrite_on: ~w[x_forwarded_host x_forwarded_port x_forwarded_proto]a
  ],
  http: [port: 4_000, transport_options: [ip: {0, 0, 0, 0, 0, 0, 0, 0}]],
  https: [
    cipher_suite: :strong,
    port: 4_001,
    transport_options: [
      certfile: Path.join(__DIR__, "../priv/adam_web/cert/selfsigned.pem"),
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      keyfile: Path.join(__DIR__, "../priv/adam_web/cert/selfsigned_key.pem")
    ]
  ],
  pubsub_server: PubSub,
  render_errors: nil,
  secret_key_base:
    "IsibqnyVMpzaQcfSobnHw1KgaAIbVCh0ko1PFgDen0RnTS6PZBfPFsZ2rDhBQTUW",
  server: true,
  url: [host: nil, path: "/", port: 443, scheme: "https"]

config :logger, level: :info
config :phoenix, :json_library, Jason
