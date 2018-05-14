defmodule PhxInPlaceDemoWeb.PageController do
  use PhxInPlaceDemoWeb, :controller

  alias PhxInPlaceDemo.Suppliers

  def index(conn, _params) do
    suppliers = Suppliers.list_suppliers()
    render(conn, "index.html", suppliers: suppliers)
  end
end
