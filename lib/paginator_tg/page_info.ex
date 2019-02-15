defmodule PaginatorTG.PageInfo do
  @moduledoc false

  @type t :: %__MODULE__{}

  defstruct start_cursor: "", end_cursor: "", has_next_page: false, has_previous_page: false

  def build(cursor_after, cursor_before) do
    %__MODULE__{
      start_cursor: empty_string_if_nil(cursor_before),
      end_cursor: empty_string_if_nil(cursor_after),
      has_next_page: !is_nil(cursor_after),
      has_previous_page: !is_nil(cursor_before)
    }
  end

  defp empty_string_if_nil(nil), do: ""
  defp empty_string_if_nil(value), do: value
end
