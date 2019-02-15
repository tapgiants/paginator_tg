defmodule PaginatorTG.Options do
  @moduledoc false

  @type t :: %__MODULE__{}

  @default_limit 30
  @default_sort_direction :desc

  @enforce_keys [:after, :before, :cursor_fields, :limit, :sort_direction, :include_total_count]
  defstruct after: "",
            before: "",
            cursor_fields: [],
            limit: @default_limit,
            sort_direction: @default_sort_direction,
            include_total_count: true

  def build(opts) when is_list(opts) do
    %__MODULE__{
      after: to_nil_if_empty(opts[:after]),
      before: to_nil_if_empty(opts[:before]),
      cursor_fields: opts[:cursor_fields],
      limit: opts[:first] || @default_limit,
      sort_direction: opts[:sort_direction] || @default_sort_direction,
      include_total_count: true
    }
  end

  defp to_nil_if_empty(""), do: nil
  defp to_nil_if_empty(value), do: value
end
