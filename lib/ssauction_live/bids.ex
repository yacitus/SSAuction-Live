defmodule SSAuction.Bids do
  @moduledoc """
  The Bids context.
  """

  import Ecto.Query, warn: false
  alias SSAuction.Repo

  alias SSAuction.Bids.BidLog
  alias SSAuction.Players.Player

  @doc """
  Returns the list of bid_logs.

  ## Examples

      iex> list_bid_logs()
      [%BidLog{}, ...]

  """
  def list_bid_logs do
    Repo.all(BidLog)
  end

  @doc """
  Gets a single bid_log.

  Raises `Ecto.NoResultsError` if the Bid log does not exist.

  ## Examples

      iex> get_bid_log!(123)
      %BidLog{}

      iex> get_bid_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bid_log!(id), do: Repo.get!(BidLog, id)

  @doc """
  Creates a bid_log.

  ## Examples

      iex> create_bid_log(%{field: value})
      {:ok, %BidLog{}}

      iex> create_bid_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bid_log(attrs \\ %{}) do
    %BidLog{}
    |> BidLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bid_log.

  ## Examples

      iex> update_bid_log(bid_log, %{field: new_value})
      {:ok, %BidLog{}}

      iex> update_bid_log(bid_log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bid_log(%BidLog{} = bid_log, attrs) do
    bid_log
    |> BidLog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bid_log.

  ## Examples

      iex> delete_bid_log(bid_log)
      {:ok, %BidLog{}}

      iex> delete_bid_log(bid_log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bid_log(%BidLog{} = bid_log) do
    Repo.delete(bid_log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bid_log changes.

  ## Examples

      iex> change_bid_log(bid_log)
      %Ecto.Changeset{data: %BidLog{}}

  """
  def change_bid_log(%BidLog{} = bid_log, attrs \\ %{}) do
    BidLog.changeset(bid_log, attrs)
  end

  def bid_logs(%Player{} = player) do
    Repo.all(from bl in BidLog,
              where: bl.player_id == ^player.id,
              join: t in assoc(bl, :team),
              preload: [team: t],
              order_by: bl.datetime)
  end

  def bid_log_type_string(type) do
    case type do
      "N" -> "nomination"
      "B" -> "bid"
      "U" -> "bid under hidden high bid"
      "H" -> "hidden high bid"
      "R" -> "rostered"
      _   -> "UNKNOWN"
    end
  end
end
