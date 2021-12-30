defmodule SSAuctionWeb.OrderedPlayerLive.FormComponent do
  use SSAuctionWeb, :live_component

  alias SSAuction.Players

  @impl true
  def update(%{ordered_player: ordered_player} = assigns, socket) do
    changeset = Players.change_ordered_player(ordered_player)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"ordered_player" => ordered_player_params}, socket) do
    changeset =
      socket.assigns.ordered_player
      |> Players.change_ordered_player(ordered_player_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"ordered_player" => ordered_player_params}, socket) do
    save_ordered_player(socket, socket.assigns.action, ordered_player_params)
  end

  defp save_ordered_player(socket, :edit, ordered_player_params) do
    case Players.update_ordered_player(socket.assigns.ordered_player, ordered_player_params) do
      {:ok, _ordered_player} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ordered player updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_ordered_player(socket, :new, ordered_player_params) do
    case Players.create_ordered_player(ordered_player_params) do
      {:ok, _ordered_player} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ordered player created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
