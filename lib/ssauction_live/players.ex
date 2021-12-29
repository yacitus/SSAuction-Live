defmodule SSAuction.Players do
  @moduledoc """
  The Players context.
  """

  import Ecto.Query, warn: false
  alias SSAuction.Repo

  alias SSAuction.Players.AllPlayer

  @doc """
  Returns the list of all_players.

  ## Examples

      iex> list_all_players()
      [%AllPlayer{}, ...]

  """
  def list_all_players do
    Repo.all(AllPlayer)
  end

  @doc """
  Gets a single all_player.

  Raises `Ecto.NoResultsError` if the All player does not exist.

  ## Examples

      iex> get_all_player!(123)
      %AllPlayer{}

      iex> get_all_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_all_player!(id), do: Repo.get!(AllPlayer, id)

  @doc """
  Creates a all_player.

  ## Examples

      iex> create_all_player(%{field: value})
      {:ok, %AllPlayer{}}

      iex> create_all_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_all_player(attrs \\ %{}) do
    %AllPlayer{}
    |> AllPlayer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a all_player.

  ## Examples

      iex> update_all_player(all_player, %{field: new_value})
      {:ok, %AllPlayer{}}

      iex> update_all_player(all_player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_all_player(%AllPlayer{} = all_player, attrs) do
    all_player
    |> AllPlayer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a all_player.

  ## Examples

      iex> delete_all_player(all_player)
      {:ok, %AllPlayer{}}

      iex> delete_all_player(all_player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_all_player(%AllPlayer{} = all_player) do
    Repo.delete(all_player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking all_player changes.

  ## Examples

      iex> change_all_player(all_player)
      %Ecto.Changeset{data: %AllPlayer{}}

  """
  def change_all_player(%AllPlayer{} = all_player, attrs \\ %{}) do
    AllPlayer.changeset(all_player, attrs)
  end
end
