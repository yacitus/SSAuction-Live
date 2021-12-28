defmodule SSAuction.Auctions.Auction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "auctions" do
    field :active, :boolean, default: false
    field :bid_timeout_seconds, :integer, default: 60*60*12 # bid timeout after new team places new high bid
    field :initial_bid_timeout_seconds, :integer, default: 60*60*24 # bid timeout after nomination
    field :must_roster_all_players, :boolean, default: true
    field :name, :string
    field :new_nominations_created, :string, default: "time" # "time" means at a time specified in the team record; "auction" means when the auction closes on a previously nominated player
    field :nominations_per_team, :integer, default: 2
    field :players_per_team, :integer
    field :seconds_before_autonomination, :integer, default: 60*60
    field :started_or_paused_at, :utc_datetime
    field :team_dollars_per_player, :integer
    field :year_range, :string

    timestamps()
  end

  @doc false
  def changeset(auction, attrs) do
    auction
    |> cast(attrs, [:name, :year_range, :nominations_per_team, :seconds_before_autonomination, :new_nominations_created, :initial_bid_timeout_seconds, :bid_timeout_seconds, :players_per_team, :must_roster_all_players, :team_dollars_per_player, :active, :started_or_paused_at])
    |> validate_required([:name, :year_range, :nominations_per_team, :seconds_before_autonomination, :new_nominations_created, :initial_bid_timeout_seconds, :bid_timeout_seconds, :players_per_team, :must_roster_all_players, :team_dollars_per_player, :active, :started_or_paused_at])
  end

  def active_emoji(auction) do
    if auction.active do
      "✅"
    else    
      "❌"
    end
  end

  def dedup_years(auction) do
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
end
