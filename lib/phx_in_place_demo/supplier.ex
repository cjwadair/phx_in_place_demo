defmodule PhxInPlaceDemo.Supplier do
  use Ecto.Schema
  import Ecto.Changeset


  schema "suppliers" do
    field :country, :string
    field :name, :string
    has_many :products, Product

    timestamps()
  end

  @doc false
  def changeset(supplier, attrs) do
    supplier
    |> cast(attrs, [:name, :country])
    |> validate_required([:name, :country])
  end
end
