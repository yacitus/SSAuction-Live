defmodule SSAuctionWeb.AuctionLive.Show do
  use SSAuctionWeb, :live_view

  alias SSAuction.Auctions
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
    auction = Auctions.get_auction!(id)
    teams = Auctions.get_teams(auction)
    {:noreply,
     socket
       |> assign(:auction, auction)
       |> assign(:teams, teams)
    }
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
