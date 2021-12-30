defmodule SSAuctionWeb.TeamLive.Show do
  use SSAuctionWeb, :live_view

  alias SSAuction.Teams
  alias SSAuction.Teams

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
end
