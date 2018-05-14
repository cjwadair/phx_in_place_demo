defmodule PhxInPlaceDemo.Repo.Migrations.CreateSuppliers do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :name, :string
      add :country, :string

      timestamps()
    end

  end
end
