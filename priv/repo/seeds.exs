# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhxInPlaceDemo.Repo.insert!(%PhxInPlaceDemo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PhxInPlaceDemo.{Repo, DataSeeder}
alias PhxInPlaceDemo.Suppliers.{Supplier, Product}

defmodule DataSeeder do

  def sku do
    range = 100173..9993762
    sku = Enum.random(range)
  end

  # def price do
  #   p = 999..3799
  #   Enum.random(p) / 100
  # end

  def fob_foreign do
    range = 4900..99999
    Enum.random(range) / 100
  end

  def generate_products(supplier_number, number_of_products, country) do
    products = 1..number_of_products
    products |> Enum.map(fn(x) -> generate_product(x,supplier_number,country) end)
  end

  def units_per_case do
    range = [6, 12, 20, 50]
    Enum.random(range)
  end

  def country do
    list = ["Canada", "United States", "Japan", "Russia", "Germany", "China"]
    Enum.random(list)
  end

  def rate_for(country) do
    case country do
    "Canada" -> 1.0
    "United States" -> 0.77
    "Japan" -> 84.25
    "Russia" -> 48.89
    "China" -> 4.92
    "Germany" -> 0.65
    end
  end

  def generate_product(product_number, supplier_number, country) do

     %Product{
       name: "Product #{supplier_number}-#{product_number}",
       fob_foreign: fob_foreign(),
       sku: sku(),
       units_per_case: units_per_case(),
       exchange_rate: rate_for(country)
     }

  end

  # def generate_supplier(n) do
  #   Repo.insert! %Supplier{
  #    name: "SUPPLIER #{n}",
  #    agency_id: 3,
  #    products: %Product{
  #      name: "Test #{n}-1",
  #      bclisting:
  #        %Bclisting{
  #        vintage: vintage(),
  #        input_quote: input_quote(),
  #        retail_price: price(),
  #        cspc: cspc(),
  #      }
  #    }
  #   }


  # end

  def generate_supplier(supplier_number, number_of_products) do
    country = country()

    Repo.insert! %Supplier{
     name: "SUPPLIER #{supplier_number}",
     country: country,
     products: generate_products(supplier_number, number_of_products, country)
    }
  end

  def generate_suppliers(number_of_suppliers, number_of_products) do
    suppliers = 1..number_of_suppliers
    suppliers |> Enum.map(fn(x) -> generate_supplier(x, number_of_products) end)
  end
end


Repo.delete_all(Supplier)
DataSeeder.generate_suppliers(5, 10)
