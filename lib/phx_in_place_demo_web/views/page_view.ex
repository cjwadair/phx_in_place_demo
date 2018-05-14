defmodule PhxInPlaceDemoWeb.PageView do
  use PhxInPlaceDemoWeb, :view

  def cost_domestic(product) do
    product.fob_foreign / product.exchange_rate |> Float.round(2)
  end

  def unit_cost(product) do
    cost_domestic(product) / product.units_per_case |> Float.round(2)
  end

  def retail_price(product) do
    unit_cost(product) * 1.25 |> Float.round(2)
  end

  def margin(product) do
    retail = retail_price(product)
    cost = unit_cost(product)
    (retail - cost) / cost |> Float.round(2) 
  end

end
