defmodule PaginatorTG.DataCase do
  use ExUnit.CaseTemplate

  using _opts do
    quote do
      alias PaginatorTG.Repo

      import Ecto
      import Ecto.Query
      import PaginatorTG.Factory

      alias PaginatorTG.Industry
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PaginatorTG.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(PaginatorTG.Repo, {:shared, self()})
    end

    :ok
  end
end
