defmodule SSAuctionWeb.BidLogLive.Index do
  use SSAuctionWeb, :live_view

  alias SSAuction.Bids
  alias SSAuction.Bids.BidLog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bid_logs, list_bid_logs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bid log")
    |> assign(:bid_log, Bids.get_bid_log!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bid log")
    |> assign(:bid_log, %BidLog{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bid logs")
    |> assign(:bid_log, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bid_log = Bids.get_bid_log!(id)
    {:ok, _} = Bids.delete_bid_log(bid_log)

    {:noreply, assign(socket, :bid_logs, list_bid_logs())}
  end

  defp list_bid_logs do
    Bids.list_bid_logs()
  end
end
