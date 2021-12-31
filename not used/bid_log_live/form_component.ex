defmodule SSAuctionWeb.BidLogLive.FormComponent do
  use SSAuctionWeb, :live_component

  alias SSAuction.Bids

  @impl true
  def update(%{bid_log: bid_log} = assigns, socket) do
    changeset = Bids.change_bid_log(bid_log)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"bid_log" => bid_log_params}, socket) do
    changeset =
      socket.assigns.bid_log
      |> Bids.change_bid_log(bid_log_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"bid_log" => bid_log_params}, socket) do
    save_bid_log(socket, socket.assigns.action, bid_log_params)
  end

  defp save_bid_log(socket, :edit, bid_log_params) do
    case Bids.update_bid_log(socket.assigns.bid_log, bid_log_params) do
      {:ok, _bid_log} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bid log updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_bid_log(socket, :new, bid_log_params) do
    case Bids.create_bid_log(bid_log_params) do
      {:ok, _bid_log} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bid log created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
