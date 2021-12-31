defmodule SSAuctionWeb.TeamLive.Show do
  use SSAuctionWeb, :live_view

  alias SSAuction.Teams
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
    team = Teams.get_team!(id)
    {:noreply,
     socket
       |> assign(:team, team)
       |> assign(:rostered_players, Teams.get_rostered_players(team))
    }
  end

  @impl true
  def handle_event("rostered_players", %{"id" => id}, socket) do
    rostered_player = Players.get_rostered_player!(id) |> Repo.preload([:player])
    {:noreply, redirect(socket, to: Routes.player_show_path(socket, :show, rostered_player.player.id))}
  end
end
