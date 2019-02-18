use Mix.Config

config :paginator_tg, ecto_repos: [PaginatorTG.Repo]

config :paginator_tg, PaginatorTG.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  username: "postgres",
  password: "postgres",
  database: "paginator_tg_test"

config :logger, :console, level: :warn
