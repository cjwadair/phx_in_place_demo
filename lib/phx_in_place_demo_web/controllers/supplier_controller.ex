defmodule PhxInPlaceDemoWeb.SupplierController do
  use PhxInPlaceDemoWeb, :controller

  alias PhxInPlaceDemo.Suppliers
  alias PhxInPlaceDemo.Suppliers.Supplier

  def index(conn, _params) do
    suppliers = Suppliers.list_suppliers()
    render(conn, "index.html", suppliers: suppliers)
  end

  def new(conn, _params) do
    changeset = Suppliers.change_supplier(%Supplier{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"supplier" => supplier_params}) do
    case Suppliers.create_supplier(supplier_params) do
      {:ok, supplier} ->
        conn
        |> put_flash(:info, "Supplier created successfully.")
        |> redirect(to: supplier_path(conn, :show, supplier))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    supplier = Suppliers.get_supplier!(id)
    render(conn, "show.html", supplier: supplier)
  end

  def edit(conn, %{"id" => id}) do
    supplier = Suppliers.get_supplier!(id)
    changeset = Suppliers.change_supplier(supplier)
    render(conn, "edit.html", supplier: supplier, changeset: changeset)
  end

  def update(conn, %{"id" => id, "supplier" => supplier_params}) do
    supplier = Suppliers.get_supplier!(id)

    case Suppliers.update_supplier(supplier, supplier_params) do
      {:ok, supplier} ->
        conn
        |> put_flash(:info, "Supplier updated successfully.")
        |> redirect(to: supplier_path(conn, :show, supplier))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", supplier: supplier, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    supplier = Suppliers.get_supplier!(id)
    {:ok, _supplier} = Suppliers.delete_supplier(supplier)

    conn
    |> put_flash(:info, "Supplier deleted successfully.")
    |> redirect(to: supplier_path(conn, :index))
  end
end
