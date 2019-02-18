defmodule PaginatorTGTest do
  @moduledoc false

  use ExUnit.Case
  use PaginatorTG.DataCase

  describe "Test paginator with records" do
    @elements_count 137

    setup do
      records =
        1..@elements_count
        |> Enum.map(fn _ -> insert!(:industry) end)
        |> Enum.reverse()

      {:ok, records: records}
    end

    test "returns 30 results per page" do
      result =
        list_records_query()
        |> Repo.paginate_tg(cursor_fields: [:inserted_at, :id], first: 30)

      assert length(result.list) == 30
      assert result.total_count == @elements_count
      assert result.page_info.has_next_page == true
      assert result.page_info.has_previous_page == false
    end

    test "returns limited number of elements", %{records: records} do
      first = 15

      cursor = prep_cursor(List.first(records))

      result =
        list_records_query()
        |> Repo.paginate_tg(
          after: cursor,
          cursor_fields: [:inserted_at, :id],
          first: first
        )

      assert length(result.list) == first
      assert result.total_count == @elements_count
      assert result.page_info.has_next_page == true
      assert result.page_info.has_previous_page == true
    end

    test "next page from higher to lower id return elements in proper order", %{records: records} do
      cursor = prep_cursor(Enum.at(records, 40))

      result =
        list_records_query()
        |> Repo.paginate_tg(
          after: cursor,
          cursor_fields: [:inserted_at, :id],
          first: 20
        )

      records_ids =
        records
        |> Enum.slice(41..60)
        |> Enum.map(& &1.id)

      result_ids =
        result.list
        |> Enum.map(& &1.id)

      assert records_ids == result_ids
      assert result.total_count == @elements_count
      assert result.page_info.has_next_page == true
      assert result.page_info.has_previous_page == true
    end

    test "last page displays proper number of elements", %{records: records} do
      cursor = prep_cursor(Enum.at(records, 120))

      result =
        list_records_query()
        |> Repo.paginate_tg(
          after: cursor,
          cursor_fields: [:inserted_at, :id],
          first: 30
        )

      records_ids =
        records
        |> Enum.slice(121..151)
        |> Enum.map(& &1.id)

      result_ids =
        result.list
        |> Enum.map(& &1.id)

      assert records_ids == result_ids
      assert result.total_count == @elements_count
      assert result.page_info.has_next_page == false
      assert result.page_info.has_previous_page == true
    end

    test "previous page from lower to higher id return elements in proper order", %{
      records: records
    } do
      cursor = prep_cursor(Enum.at(records, 61))

      result =
        list_records_query()
        |> Repo.paginate_tg(
          before: cursor,
          cursor_fields: [:inserted_at, :id],
          first: 20
        )

      records_ids =
        records
        |> Enum.slice(41..60)
        |> Enum.map(& &1.id)

      result_ids =
        result.list
        |> Enum.map(& &1.id)

      assert records_ids == result_ids
      assert result.total_count == @elements_count
      assert result.page_info.has_next_page == true
      assert result.page_info.has_previous_page == true
    end

    test "first page contains correct number of elements", %{records: records} do
      cursor = prep_cursor(Enum.at(records, 20))

      result =
        list_records_query()
        |> Repo.paginate_tg(
          before: cursor,
          cursor_fields: [:inserted_at, :id],
          first: 20
        )

      records_ids =
        records
        |> Enum.slice(0..19)
        |> Enum.map(& &1.id)

      result_ids =
        result.list
        |> Enum.map(& &1.id)

      assert records_ids == result_ids
      assert result.total_count == @elements_count
      assert result.page_info.has_next_page == true
      assert result.page_info.has_previous_page == false
    end

    test "last page returned with correct page info", %{records: records} do
      cursor = prep_cursor(Enum.at(records, 120))

      result =
        list_records_query()
        |> Repo.paginate_tg(
          after: cursor,
          cursor_fields: [:inserted_at, :id],
          first: 20
        )

      assert result.total_count == @elements_count
      assert result.page_info.has_next_page == false
      assert result.page_info.has_previous_page == true
    end

    test "first page returned with correct page info" do
      result =
        list_records_query()
        |> Repo.paginate_tg(
          cursor_fields: [:inserted_at, :id],
          first: 20
        )

      assert result.total_count == @elements_count
      assert result.page_info.has_previous_page == false
      assert result.page_info.has_next_page == true
    end
  end

  describe "Test paginator without records" do
    test "proper values are returned on an empty params call" do
      result =
        list_records_query()
        |> Repo.paginate_tg(cursor_fields: [:inserted_at, :id])

      assert result == %PaginatorTG.List{
               list: [],
               page_info: %PaginatorTG.PageInfo{
                 start_cursor: "",
                 end_cursor: "",
                 has_next_page: false,
                 has_previous_page: false
               },
               total_count: 0
             }
    end
  end

  defp list_records_query do
    from(ind in Industry, order_by: [desc: ind.inserted_at, desc: ind.id])
  end

  defp prep_cursor(record) do
    Paginator.cursor_for_record(record, [:inserted_at, :id])
  end
end
