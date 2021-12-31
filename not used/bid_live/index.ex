defmodule SSAuctionWeb.BidLive.Index do
  use SSAuctionWeb, :live_view

  alias SSAuction.Bids
  alias SSAuction.Bids.Bid

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bids, list_bids())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bid")
    |> assign(:bid, Bids.get_bid!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bid")
    |> assign(:bid, %Bid{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bids")
    |> assign(:bid, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bid = Bids.get_bid!(id)
    {:ok, _} = Bids.delete_bid(bid)

    {:noreply, assign(socket, :bids, list_bids())}
  end

  defp list_bids do
    Bids.list_bids()
  end
end
