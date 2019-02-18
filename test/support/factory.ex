defmodule PaginatorTG.Factory do
  @moduledoc false

  alias PaginatorTG.Repo
  alias PaginatorTG.Industry

  def build(:industry) do
    %Industry{
      name: "IT"
    }
  end

  def build(factory_name, params) do
    factory_name |> build |> struct(params)
  end

  def insert!(factory_name, params \\ []) do
    factory_name |> build(params) |> Repo.insert!()
  end
end
