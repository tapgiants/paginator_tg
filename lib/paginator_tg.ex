defmodule PaginatorTG do
  @moduledoc """
  Defines an wrapper around the [`Paginator`](https://hexdocs.pm/paginator) hex package.
  All provided functions from the `Paginator` package are available via `PaginatorTG` package.

  This module provides `paginate_tg/2` function which decorates the returned result from
  the `Paginator.paginate/3` in order to follow Tap Giants data conventions.

  ## Usage
      defmodule MyApp.Repo do
        use Ecto.Repo,
            otp_app: :my_app,
            adapter: Ecto.Adapters.Postgres

        use PaginatorTG
      end
  """

  alias PaginatorTG.{List, Options}

  defmacro __using__(_opts) do
    quote do
      alias PaginatorTG

      use Paginator

      def paginate_tg(queryable, opts), do: PaginatorTG.paginate_tg(__MODULE__, queryable, opts)
    end
  end

  @doc """
  Decorates the fetched result from the `Paginator.paginate/3`.
  ## Options
    * `:after` - Fetch the records after this cursor.
    * `:before` - Fetch the records before this cursor.
    * `:cursor_fields` - The fields used to determine the cursor. In most cases,
    this should be the same fields as the ones used for sorting in the query.
    * `:first` - Limits the number of records returned per page. Note that this
    number will be capped by `:maximum_limit`. Defaults to `30`.
    * `:sort_direction` - The direction used for sorting. Defaults to `:desc`.

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
  """
  @callback paginate(queryable :: Ecto.Query.t(), opts :: PaginatorTG.Options.t()) ::
              PaginatorTG.List.t()

  def paginate_tg(repo, queryable, opts) do
    options =
      opts
      |> Options.build()
      |> Map.to_list()

    queryable
    |> repo.paginate(options)
    |> List.build()
  end
end
