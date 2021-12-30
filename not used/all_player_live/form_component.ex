defmodule SSAuctionWeb.AllPlayerLive.FormComponent do
  use SSAuctionWeb, :live_component

  alias SSAuction.Players

  @impl true
  def update(%{all_player: all_player} = assigns, socket) do
    changeset = Players.change_all_player(all_player)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"all_player" => all_player_params}, socket) do
    changeset =
      socket.assigns.all_player
      |> Players.change_all_player(all_player_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"all_player" => all_player_params}, socket) do
    save_all_player(socket, socket.assigns.action, all_player_params)
  end

  defp save_all_player(socket, :edit, all_player_params) do
    case Players.update_all_player(socket.assigns.all_player, all_player_params) do
      {:ok, _all_player} ->
        {:noreply,
         socket
         |> put_flash(:info, "All player updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_all_player(socket, :new, all_player_params) do
    case Players.create_all_player(all_player_params) do
      {:ok, _all_player} ->
        {:noreply,
         socket
         |> put_flash(:info, "All player created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
