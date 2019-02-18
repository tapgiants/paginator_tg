# PaginatorTG

An wrapper around [Paginator](https://github.com/duffelhq/paginator).
Decorates the result returned from the [Paginator](https://github.com/duffelhq/paginator) by following
the [Tap Giants](https://github.com/tapgiants) data conventions.
All provided functions from the `Paginator` package are available via `PaginatorTG` package.

[Documentation](https://hexdocs.pm/paginator_tg)

## Installation

The package can be installed by adding `paginator_tg` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:paginator_tg, "~> 0.1.1"}
  ]
end
```

## Usage

1. Add `PaginatorTG` to your repo.

```elixir
  defmodule MyApp.Repo do
    use Ecto.Repo,
        otp_app: :my_app,
        adapter: Ecto.Adapters.Postgres

    use PaginatorTG
  end
```

2. Use the `paginate_tg/2` function to paginate your queries.

```elixir
  ## Simple example
  query = from(ind in Industry, order_by: [desc: ind.inserted_at, desc: ind.id])

  %{
    list: list,
    total_count: total_count,
    page_info: %{
      start_cursor: start_cursor,
      end_cursor: end_cursor,
      has_next_page: _has_next_page,
      has_previous_page: _has_previous_page,
    }
  } = Repo.paginate_tg(query, cursor_fields: [:inserted_at, :id], first: 30)

  ## Example with cursors

    query = from(ind in Industry, order_by: [desc: ind.inserted_at, desc: ind.id])
    %{
      list: list,
      total_count: total_count,
      page_info: %{
        start_cursor: start_cursor,
        end_cursor: end_cursor,
        has_next_page: _has_next_page,
        has_previous_page: _has_previous_page,
      }
    } = Repo.paginate_tg(query, cursor_fields: [:inserted_at, :id], first: 30)

    query = from(ind in Industry, order_by: [desc: ind.inserted_at, desc: ind.id])
    Repo.paginate_tg(
      query,
      after: end_cursor,
      first: 30,
      cursor_fields: [:inserted_at, :id]
    )
```

## TODOs

- Better documentation
- Development section
- License
