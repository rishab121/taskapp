use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :taskapp, TaskappWeb.Endpoint,
  secret_key_base: "jRhDP523VR/kzp+fiXcpzAttY4VxCMivObB7h6nx+a81tpiKRLqgHt0OHPNiSrXn"

# Configure your database
config :taskapp, Taskapp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "taskapp",
  password: "sdvm5832",
  database: "taskapp_prod",
  pool_size: 15
