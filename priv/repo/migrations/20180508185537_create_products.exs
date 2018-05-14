defmodule PhxInPlaceDemo.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :sku, :integer
      add :fob_foreign, :float
      add :units_per_case, :integer
      add :exchange_rate, :float
      add :supplier_id, references(:suppliers, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:products, [:supplier_id])
  end
end
