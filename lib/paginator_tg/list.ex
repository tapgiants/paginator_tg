defmodule PaginatorTG.List do
  @moduledoc false

  alias PaginatorTG.PageInfo

  @type t :: %__MODULE__{}

  @enforce_keys [:list, :total_count, :page_info]
  defstruct list: [], total_count: 0, page_info: %PageInfo{}

  def build(%{entries: entries, metadata: metadata}) when is_list(entries) do
    %__MODULE__{
      list: entries,
      total_count: metadata.total_count,
      page_info: PageInfo.build(metadata.after, metadata.before)
    }
  end
end
