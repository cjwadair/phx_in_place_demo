defmodule PhxInPlaceDemoWeb.PipChannel do

  use Phoenix.Channel
  use PhxInPlace.ChannelManager

  alias PhxInPlaceDemo.Suppliers

  def join("pip:demo", _payload, socket) do
    {:ok, "successfully joined", socket}
  end

  def handle_in("row_update", payload, socket) do
    case Suppliers.get_product!(payload["id"]) do
        nil ->
          IO.puts "Error getting Product:"
          {:reply, {:error, %{reason: "response was nil"}}, socket}
        product ->
          html = return_row_data({:ok, product}, "product_row_partial.html", socket)
          {:reply, {:ok, %{product_id: product.id, html: html}}, socket}
    end
  end

  def handle_in("pip:success", payload, socket) do
      IO.puts "SUCCESS: #{inspect payload["target"]}"
      {:noreply, socket}
    end

  # called from handle_in function. Returns the partial template as a string to pass back to client
  defp return_row_data(response, partialName, socket) do
    case response do
    {:ok, product} ->
      html = Phoenix.View.render_to_string(PhxInPlaceDemoWeb.PageView, partialName, product: product)
    {:error, reason} ->
      {:error, %{reason: "channel: No such product #{inspect reason}"}}
    end
  end

end
