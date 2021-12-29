defmodule SSAuctionWeb.AllPlayerLive.Show do
  use SSAuctionWeb, :live_view

  alias SSAuction.Players

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:all_player, Players.get_all_player!(id))}
  end

  defp page_title(:show), do: "Show All player"
  defp page_title(:edit), do: "Edit All player"
end
