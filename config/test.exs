import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ssauction_live, SSAuction.Repo,
  username: "postgres",
  password: "postgres",
  database: "ssauction_live_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ssauction_live, SSAuctionWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Nhjjaomdv07Nl2s8NBaIQZGH+950kYFr46Vmzjes0d4GeVdYz9cgD51nqhKH/Kbw",
  server: false

# In test we don't send emails.
config :ssauction_live, SSAuction.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
