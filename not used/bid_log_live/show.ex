defmodule SSAuctionWeb.BidLogLive.Show do
  use SSAuctionWeb, :live_view

  alias SSAuction.Bids

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bid_log, Bids.get_bid_log!(id))}
  end

  defp page_title(:show), do: "Show Bid log"
  defp page_title(:edit), do: "Edit Bid log"
end
