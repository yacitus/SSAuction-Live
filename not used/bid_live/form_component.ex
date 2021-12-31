defmodule SSAuctionWeb.BidLive.FormComponent do
  use SSAuctionWeb, :live_component

  alias SSAuction.Bids

  @impl true
  def update(%{bid: bid} = assigns, socket) do
    changeset = Bids.change_bid(bid)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"bid" => bid_params}, socket) do
    changeset =
      socket.assigns.bid
      |> Bids.change_bid(bid_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"bid" => bid_params}, socket) do
    save_bid(socket, socket.assigns.action, bid_params)
  end

  defp save_bid(socket, :edit, bid_params) do
    case Bids.update_bid(socket.assigns.bid, bid_params) do
      {:ok, _bid} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bid updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_bid(socket, :new, bid_params) do
    case Bids.create_bid(bid_params) do
      {:ok, _bid} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bid created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
