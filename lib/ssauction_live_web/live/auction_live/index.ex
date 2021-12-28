defmodule SSAuctionWeb.AuctionLive.Index do
  use SSAuctionWeb, :live_view

  alias SSAuction.Auctions
  alias SSAuction.Auctions.Auction

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :auctions, Auctions.list_auctions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Auction")
    |> assign(:auction, Auctions.get_auction!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Auction")
    |> assign(:auction, %Auction{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Auctions")
    |> assign(:auction, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    auction = Auctions.get_auction!(id)
    {:ok, _} = Auctions.delete_auction(auction)

    {:noreply, assign(socket, :auctions, Auctions.list_auctions())}
  end
end
