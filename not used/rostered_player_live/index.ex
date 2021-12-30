defmodule SSAuctionWeb.RosteredPlayerLive.Index do
  use SSAuctionWeb, :live_view

  alias SSAuction.Players
  alias SSAuction.Players.RosteredPlayer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :rostered_players, list_rostered_players())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Rostered player")
    |> assign(:rostered_player, Players.get_rostered_player!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Rostered player")
    |> assign(:rostered_player, %RosteredPlayer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rostered players")
    |> assign(:rostered_player, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    rostered_player = Players.get_rostered_player!(id)
    {:ok, _} = Players.delete_rostered_player(rostered_player)

    {:noreply, assign(socket, :rostered_players, list_rostered_players())}
  end

  defp list_rostered_players do
    Players.list_rostered_players()
  end
end
