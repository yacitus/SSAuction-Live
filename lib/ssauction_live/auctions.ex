defmodule SSAuction.Auctions do
  @moduledoc """
  The Auctions context.
  """

  import Ecto.Query, warn: false
  alias SSAuction.Repo

  alias SSAuction.Auctions.Auction

  @doc """
  Returns the list of auctions.

  ## Examples

      iex> list_auctions()
      [%Auction{}, ...]

  """
  def list_auctions do
    Repo.all(Auction)
  end

  @doc """
  Gets a single auction.

  Raises `Ecto.NoResultsError` if the Auction does not exist.

  ## Examples

      iex> get_auction!(123)
      %Auction{}

      iex> get_auction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_auction!(id), do: Repo.get!(Auction, id)

  @doc """
  Creates a auction.

  ## Examples

      iex> create_auction(%{field: value})
      {:ok, %Auction{}}

      iex> create_auction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_auction(attrs \\ %{}) do
    %Auction{}
    |> Auction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a auction.

  ## Examples

      iex> update_auction(auction, %{field: new_value})
      {:ok, %Auction{}}

      iex> update_auction(auction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_auction(%Auction{} = auction, attrs) do
    auction
    |> Auction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a auction.

  ## Examples

      iex> delete_auction(auction)
      {:ok, %Auction{}}

      iex> delete_auction(auction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_auction(%Auction{} = auction) do
    Repo.delete(auction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking auction changes.

  ## Examples

      iex> change_auction(auction)
      %Ecto.Changeset{data: %Auction{}}

  """
  def change_auction(%Auction{} = auction, attrs \\ %{}) do
    Auction.changeset(auction, attrs)
  end

  def active_emoji(auction) do
    if auction.active do
      "✅"
    else    
      "❌"
    end
  end

  def dedup_years(%Auction{} = auction) do
    years_and_league = correct_league(auction.year_range)

    case Regex.named_captures(~r/(?<year1>\d{4})-(?<year2>\d{4})-(?<league>\w\w)/, years_and_league) do
      %{"year1" => year1, "year2" => year2, "league" => league} ->
        if year1 == year2 do
          year1 <> "-" <> league
        else
          years_and_league
        end
      _ ->
       years_and_league 
    end
  end

  defp correct_league(year_range) do
    if String.slice(year_range, -2, 2) == "SL" do
      String.slice(year_range, 0..-3) <> "CL"
    else
      year_range
    end
  end

  def get_teams(%Auction{} = auction) do
    Repo.preload(auction, [:teams]).teams
  end
end
