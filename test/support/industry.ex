defmodule PaginatorTG.Industry do
  use Ecto.Schema

  schema "industries" do
    field(:name, :string)

    timestamps()
  end
end
