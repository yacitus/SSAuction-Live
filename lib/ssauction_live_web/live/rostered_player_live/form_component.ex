defmodule SSAuctionWeb.RosteredPlayerLive.FormComponent do
  use SSAuctionWeb, :live_component

  alias SSAuction.Players

  @impl true
  def update(%{rostered_player: rostered_player} = assigns, socket) do
    changeset = Players.change_rostered_player(rostered_player)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"rostered_player" => rostered_player_params}, socket) do
    changeset =
      socket.assigns.rostered_player
      |> Players.change_rostered_player(rostered_player_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"rostered_player" => rostered_player_params}, socket) do
    save_rostered_player(socket, socket.assigns.action, rostered_player_params)
  end

  defp save_rostered_player(socket, :edit, rostered_player_params) do
    case Players.update_rostered_player(socket.assigns.rostered_player, rostered_player_params) do
      {:ok, _rostered_player} ->
        {:noreply,
         socket
         |> put_flash(:info, "Rostered player updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_rostered_player(socket, :new, rostered_player_params) do
    case Players.create_rostered_player(rostered_player_params) do
      {:ok, _rostered_player} ->
        {:noreply,
         socket
         |> put_flash(:info, "Rostered player created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
