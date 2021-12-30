defmodule SSAuctionWeb.OrderedPlayerLive.Index do
  use SSAuctionWeb, :live_view

  alias SSAuction.Players
  alias SSAuction.Players.OrderedPlayer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :ordered_players, list_ordered_players())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ordered player")
    |> assign(:ordered_player, Players.get_ordered_player!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ordered player")
    |> assign(:ordered_player, %OrderedPlayer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Ordered players")
    |> assign(:ordered_player, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ordered_player = Players.get_ordered_player!(id)
    {:ok, _} = Players.delete_ordered_player(ordered_player)

    {:noreply, assign(socket, :ordered_players, list_ordered_players())}
  end

  defp list_ordered_players do
    Players.list_ordered_players()
  end
end
