defmodule SSAuctionWeb.AuctionLive.Show do
  use SSAuctionWeb, :live_view

  alias SSAuction.Auctions
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
    auction = Auctions.get_auction!(id)
    {:noreply,
     socket
       |> assign(:auction, auction)
       |> assign(:teams, Auctions.get_teams(auction))
       |> assign(:rostered_players, Auctions.get_rostered_players(auction))
    }
  end

  @impl true
  def handle_event("team", %{"id" => id}, socket) do
    {:noreply, redirect(socket, to: Routes.team_show_path(socket, :show, id))}
  end

  @impl true
  def handle_event("rostered_players", %{"id" => id}, socket) do
    rostered_player = Players.get_rostered_player!(id) |> Repo.preload([:player])
    {:noreply, redirect(socket, to: Routes.player_show_path(socket, :show, rostered_player.player.id))}
  end

  defp append(string1, string2) do
    if String.length(string1) > 0 do
      string1 <> ", " <> string2
    else
      string2
    end
  end

  defp pluralize(number) do
    if number > 1 do
      "s"
    else
      ""
    end
  end

  defp seconds_to_string(seconds) do
    string = ""
    days = div(seconds, 86400)
    string = if days != 0 do
      append(string, Integer.to_string(days) <> " day" <> pluralize(days))
    else
      string
    end
    seconds = rem(seconds, 86400)
    hours = div(seconds, 3600)
    string = if hours != 0 do
      append(string, Integer.to_string(hours) <> " hour" <> pluralize(hours))
    else
      string
    end
    seconds = rem(seconds, 3600)
    minutes = div(seconds, 60)
    string = if minutes != 0 do
      append(string, Integer.to_string(minutes) <> " minute" <> pluralize(minutes))
    else
      string
    end
    seconds = rem(seconds, 60)
    if seconds != 0 do
      append(string, Integer.to_string(seconds) <> " second" <> pluralize(seconds))
    else
      string
    end
  end
end
