defmodule SSAuction.AuctionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SSAuction.Auctions` context.
  """

  @doc """
  Generate a auction.
  """
  def auction_fixture(attrs \\ %{}) do
    {:ok, auction} =
      attrs
      |> Enum.into(%{
        active: true,
        bid_timeout_seconds: 42,
        initial_bid_timeout_seconds: 42,
        must_roster_all_players: true,
        name: "some name",
        new_nominations_created: "some new_nominations_created",
        nominations_per_team: 42,
        players_per_team: 42,
        seconds_before_autonomination: 42,
        started_or_paused_at: ~U[2021-12-19 03:52:00Z],
        team_dollars_per_player: 42,
        year_range: "some year_range"
      })
      |> SSAuction.Auctions.create_auction()

    auction
  end
end
