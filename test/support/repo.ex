defmodule PaginatorTG.Repo do
  use Ecto.Repo,
    otp_app: :paginator_tg,
    adapter: Ecto.Adapters.Postgres

  use PaginatorTG
end
