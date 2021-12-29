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

  alias SSAuction.Players.Player

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  def list_players do
    Repo.all(Player)
  end

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{data: %Player{}}

  """
  def change_player(%Player{} = player, attrs \\ %{}) do
    Player.changeset(player, attrs)
  end
end
