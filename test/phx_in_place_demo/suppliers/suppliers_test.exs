defmodule PhxInPlaceDemo.SuppliersTest do
  use PhxInPlaceDemo.DataCase

  alias PhxInPlaceDemo.Suppliers

  describe "suppliers" do
    alias PhxInPlaceDemo.Suppliers.Supplier

    @valid_attrs %{country: "some country", name: "some name"}
    @update_attrs %{country: "some updated country", name: "some updated name"}
    @invalid_attrs %{country: nil, name: nil}

    def supplier_fixture(attrs \\ %{}) do
      {:ok, supplier} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Suppliers.create_supplier()

      supplier
    end

    test "list_suppliers/0 returns all suppliers" do
      supplier = supplier_fixture()
      assert Suppliers.list_suppliers() == [supplier]
    end

    test "get_supplier!/1 returns the supplier with given id" do
      supplier = supplier_fixture()
      assert Suppliers.get_supplier!(supplier.id) == supplier
    end

    test "create_supplier/1 with valid data creates a supplier" do
      assert {:ok, %Supplier{} = supplier} = Suppliers.create_supplier(@valid_attrs)
      assert supplier.country == "some country"
      assert supplier.name == "some name"
    end

    test "create_supplier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Suppliers.create_supplier(@invalid_attrs)
    end

    test "update_supplier/2 with valid data updates the supplier" do
      supplier = supplier_fixture()
      assert {:ok, supplier} = Suppliers.update_supplier(supplier, @update_attrs)
      assert %Supplier{} = supplier
      assert supplier.country == "some updated country"
      assert supplier.name == "some updated name"
    end

    test "update_supplier/2 with invalid data returns error changeset" do
      supplier = supplier_fixture()
      assert {:error, %Ecto.Changeset{}} = Suppliers.update_supplier(supplier, @invalid_attrs)
      assert supplier == Suppliers.get_supplier!(supplier.id)
    end

    test "delete_supplier/1 deletes the supplier" do
      supplier = supplier_fixture()
      assert {:ok, %Supplier{}} = Suppliers.delete_supplier(supplier)
      assert_raise Ecto.NoResultsError, fn -> Suppliers.get_supplier!(supplier.id) end
    end

    test "change_supplier/1 returns a supplier changeset" do
      supplier = supplier_fixture()
      assert %Ecto.Changeset{} = Suppliers.change_supplier(supplier)
    end
  end

  describe "products" do
    alias PhxInPlaceDemo.Suppliers.Product

    @valid_attrs %{fob_foreign: "120.5", name: "some name", sku: 42, units_per_case: 42}
    @update_attrs %{fob_foreign: "456.7", name: "some updated name", sku: 43, units_per_case: 43}
    @invalid_attrs %{fob_foreign: nil, name: nil, sku: nil, units_per_case: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Suppliers.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Suppliers.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Suppliers.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Suppliers.create_product(@valid_attrs)
      assert product.fob_foreign == Decimal.new("120.5")
      assert product.name == "some name"
      assert product.sku == 42
      assert product.units_per_case == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Suppliers.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, product} = Suppliers.update_product(product, @update_attrs)
      assert %Product{} = product
      assert product.fob_foreign == Decimal.new("456.7")
      assert product.name == "some updated name"
      assert product.sku == 43
      assert product.units_per_case == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Suppliers.update_product(product, @invalid_attrs)
      assert product == Suppliers.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Suppliers.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Suppliers.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Suppliers.change_product(product)
    end
  end
end
