defmodule SSAuction.AuctionsTest do
  use SSAuction.DataCase

  alias SSAuction.Auctions

  describe "auctions" do
    alias SSAuction.Auctions.Auction

    import SSAuction.AuctionsFixtures

    @invalid_attrs %{active: nil, bid_timeout_seconds: nil, initial_bid_timeout_seconds: nil, must_roster_all_players: nil, name: nil, new_nominations_created: nil, nominations_per_team: nil, players_per_team: nil, seconds_before_autonomination: nil, started_or_paused_at: nil, team_dollars_per_player: nil, year_range: nil}

    test "list_auctions/0 returns all auctions" do
      auction = auction_fixture()
      assert Auctions.list_auctions() == [auction]
    end

    test "get_auction!/1 returns the auction with given id" do
      auction = auction_fixture()
      assert Auctions.get_auction!(auction.id) == auction
    end

    test "create_auction/1 with valid data creates a auction" do
      valid_attrs = %{active: true, bid_timeout_seconds: 42, initial_bid_timeout_seconds: 42, must_roster_all_players: true, name: "some name", new_nominations_created: "some new_nominations_created", nominations_per_team: 42, players_per_team: 42, seconds_before_autonomination: 42, started_or_paused_at: ~U[2021-12-19 03:52:00Z], team_dollars_per_player: 42, year_range: "some year_range"}

      assert {:ok, %Auction{} = auction} = Auctions.create_auction(valid_attrs)
      assert auction.active == true
      assert auction.bid_timeout_seconds == 42
      assert auction.initial_bid_timeout_seconds == 42
      assert auction.must_roster_all_players == true
      assert auction.name == "some name"
      assert auction.new_nominations_created == "some new_nominations_created"
      assert auction.nominations_per_team == 42
      assert auction.players_per_team == 42
      assert auction.seconds_before_autonomination == 42
      assert auction.started_or_paused_at == ~U[2021-12-19 03:52:00Z]
      assert auction.team_dollars_per_player == 42
      assert auction.year_range == "some year_range"
    end

    test "create_auction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auctions.create_auction(@invalid_attrs)
    end

    test "update_auction/2 with valid data updates the auction" do
      auction = auction_fixture()
      update_attrs = %{active: false, bid_timeout_seconds: 43, initial_bid_timeout_seconds: 43, must_roster_all_players: false, name: "some updated name", new_nominations_created: "some updated new_nominations_created", nominations_per_team: 43, players_per_team: 43, seconds_before_autonomination: 43, started_or_paused_at: ~U[2021-12-20 03:52:00Z], team_dollars_per_player: 43, year_range: "some updated year_range"}

      assert {:ok, %Auction{} = auction} = Auctions.update_auction(auction, update_attrs)
      assert auction.active == false
      assert auction.bid_timeout_seconds == 43
      assert auction.initial_bid_timeout_seconds == 43
      assert auction.must_roster_all_players == false
      assert auction.name == "some updated name"
      assert auction.new_nominations_created == "some updated new_nominations_created"
      assert auction.nominations_per_team == 43
      assert auction.players_per_team == 43
      assert auction.seconds_before_autonomination == 43
      assert auction.started_or_paused_at == ~U[2021-12-20 03:52:00Z]
      assert auction.team_dollars_per_player == 43
      assert auction.year_range == "some updated year_range"
    end

    test "update_auction/2 with invalid data returns error changeset" do
      auction = auction_fixture()
      assert {:error, %Ecto.Changeset{}} = Auctions.update_auction(auction, @invalid_attrs)
      assert auction == Auctions.get_auction!(auction.id)
    end

    test "delete_auction/1 deletes the auction" do
      auction = auction_fixture()
      assert {:ok, %Auction{}} = Auctions.delete_auction(auction)
      assert_raise Ecto.NoResultsError, fn -> Auctions.get_auction!(auction.id) end
    end

    test "change_auction/1 returns a auction changeset" do
      auction = auction_fixture()
      assert %Ecto.Changeset{} = Auctions.change_auction(auction)
    end
  end
end
