defmodule PaginatorTG.TestMigration do
  use Ecto.Migration

  def change do
    create table(:industries) do
      add(:name, :string, null: false, size: 255)

      timestamps()
    end
  end
end
