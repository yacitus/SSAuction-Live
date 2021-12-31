defmodule SSAuctionWeb.AuctionLive.RosteredPlayers do
  use SSAuctionWeb, :live_view

  alias SSAuction.Auctions
  alias SSAuction.Players
  alias SSAuction.Repo

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_locale()
      |> assign_timezone()
      |> assign_timezone_offset()
  
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    auction = Auctions.get_auction!(id)
    {:noreply,
     socket
       |> assign(:auction, auction)
       |> assign(:rostered_players, Auctions.get_rostered_players(auction))
    }
  end

  @impl true
  def handle_event("rostered_players", %{"id" => id}, socket) do
    rostered_player = Players.get_rostered_player!(id) |> Repo.preload([:player])
    {:noreply, redirect(socket, to: Routes.player_show_path(socket, :show, rostered_player.player.id))}
  end
end
