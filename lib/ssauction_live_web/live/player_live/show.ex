defmodule SSAuctionWeb.PlayerLive.Show do
  use SSAuctionWeb, :live_view

  alias SSAuction.Players
  alias SSAuction.Bids
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
    player = Players.get_player!(id)
    player = Repo.preload(player, :rostered_player)
    rostered_player = player.rostered_player
    rostered_player = Repo.preload(rostered_player, :team)
    {:noreply,
     socket
       |> assign(:player, player)
       |> assign(:rostered_player, rostered_player)
       |> assign(:bid_logs, Bids.bid_logs(player))
    }
  end
end
