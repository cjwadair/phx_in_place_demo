defmodule PhxInPlaceDemo.Suppliers.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhxInPlaceDemo.Suppliers.{Product, Supplier}


  schema "products" do
    field :fob_foreign, :float
    field :name, :string
    field :sku, :integer
    field :units_per_case, :integer
    field :exchange_rate, :float
    belongs_to :supplier, Supplier

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :sku, :fob_foreign, :units_per_case, :supplier_id, :exchange_rate])
    |> validate_required([:name, :sku, :fob_foreign, :units_per_case, :supplier_id, :exchange_rate])
    |> validate_number(:sku, greater_than: 9999, less_than: 10000000 )
  end
end
