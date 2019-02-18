Application.ensure_all_started(:postgrex)
Application.ensure_all_started(:ecto)

# Load up the repository, start it, and run migrations
_ = Ecto.Adapters.Postgres.storage_down(PaginatorTG.Repo.config())
:ok = Ecto.Adapters.Postgres.storage_up(PaginatorTG.Repo.config())
{:ok, _} = PaginatorTG.Repo.start_link()
:ok = Ecto.Migrator.up(PaginatorTG.Repo, 0, PaginatorTG.TestMigration, log: false)

Ecto.Adapters.SQL.Sandbox.mode(PaginatorTG.Repo, :manual)

ExUnit.start()
