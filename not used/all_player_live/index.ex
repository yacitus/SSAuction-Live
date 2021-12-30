defmodule SSAuctionWeb.AllPlayerLive.Index do
  use SSAuctionWeb, :live_view

  alias SSAuction.Players
  alias SSAuction.Players.AllPlayer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :all_players, list_all_players())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit All player")
    |> assign(:all_player, Players.get_all_player!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New All player")
    |> assign(:all_player, %AllPlayer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing All players")
    |> assign(:all_player, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    all_player = Players.get_all_player!(id)
    {:ok, _} = Players.delete_all_player(all_player)

    {:noreply, assign(socket, :all_players, list_all_players())}
  end

  defp list_all_players do
    Players.list_all_players()
  end
end
