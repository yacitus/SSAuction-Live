defmodule SSAuction.BidsTest do
  use SSAuction.DataCase

  alias SSAuction.Bids

  describe "bid_logs" do
    alias SSAuction.Bids.BidLog

    import SSAuction.BidsFixtures

    @invalid_attrs %{amount: nil, datetime: nil, type: nil}

    test "list_bid_logs/0 returns all bid_logs" do
      bid_log = bid_log_fixture()
      assert Bids.list_bid_logs() == [bid_log]
    end

    test "get_bid_log!/1 returns the bid_log with given id" do
      bid_log = bid_log_fixture()
      assert Bids.get_bid_log!(bid_log.id) == bid_log
    end

    test "create_bid_log/1 with valid data creates a bid_log" do
      valid_attrs = %{amount: 42, datetime: ~U[2021-12-30 14:45:00Z], type: "some type"}

      assert {:ok, %BidLog{} = bid_log} = Bids.create_bid_log(valid_attrs)
      assert bid_log.amount == 42
      assert bid_log.datetime == ~U[2021-12-30 14:45:00Z]
      assert bid_log.type == "some type"
    end

    test "create_bid_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bids.create_bid_log(@invalid_attrs)
    end

    test "update_bid_log/2 with valid data updates the bid_log" do
      bid_log = bid_log_fixture()
      update_attrs = %{amount: 43, datetime: ~U[2021-12-31 14:45:00Z], type: "some updated type"}

      assert {:ok, %BidLog{} = bid_log} = Bids.update_bid_log(bid_log, update_attrs)
      assert bid_log.amount == 43
      assert bid_log.datetime == ~U[2021-12-31 14:45:00Z]
      assert bid_log.type == "some updated type"
    end

    test "update_bid_log/2 with invalid data returns error changeset" do
      bid_log = bid_log_fixture()
      assert {:error, %Ecto.Changeset{}} = Bids.update_bid_log(bid_log, @invalid_attrs)
      assert bid_log == Bids.get_bid_log!(bid_log.id)
    end

    test "delete_bid_log/1 deletes the bid_log" do
      bid_log = bid_log_fixture()
      assert {:ok, %BidLog{}} = Bids.delete_bid_log(bid_log)
      assert_raise Ecto.NoResultsError, fn -> Bids.get_bid_log!(bid_log.id) end
    end

    test "change_bid_log/1 returns a bid_log changeset" do
      bid_log = bid_log_fixture()
      assert %Ecto.Changeset{} = Bids.change_bid_log(bid_log)
    end
  end

  describe "bids" do
    alias SSAuction.Bids.Bid

    import SSAuction.BidsFixtures

    @invalid_attrs %{bid_amount: nil, closed: nil, expires_at: nil, hidden_high_bid: nil, nominated_by: nil}

    test "list_bids/0 returns all bids" do
      bid = bid_fixture()
      assert Bids.list_bids() == [bid]
    end

    test "get_bid!/1 returns the bid with given id" do
      bid = bid_fixture()
      assert Bids.get_bid!(bid.id) == bid
    end

    test "create_bid/1 with valid data creates a bid" do
      valid_attrs = %{bid_amount: 42, closed: true, expires_at: ~U[2021-12-30 15:27:00Z], hidden_high_bid: 42, nominated_by: 42}

      assert {:ok, %Bid{} = bid} = Bids.create_bid(valid_attrs)
      assert bid.bid_amount == 42
      assert bid.closed == true
      assert bid.expires_at == ~U[2021-12-30 15:27:00Z]
      assert bid.hidden_high_bid == 42
      assert bid.nominated_by == 42
    end

    test "create_bid/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bids.create_bid(@invalid_attrs)
    end

    test "update_bid/2 with valid data updates the bid" do
      bid = bid_fixture()
      update_attrs = %{bid_amount: 43, closed: false, expires_at: ~U[2021-12-31 15:27:00Z], hidden_high_bid: 43, nominated_by: 43}

      assert {:ok, %Bid{} = bid} = Bids.update_bid(bid, update_attrs)
      assert bid.bid_amount == 43
      assert bid.closed == false
      assert bid.expires_at == ~U[2021-12-31 15:27:00Z]
      assert bid.hidden_high_bid == 43
      assert bid.nominated_by == 43
    end

    test "update_bid/2 with invalid data returns error changeset" do
      bid = bid_fixture()
      assert {:error, %Ecto.Changeset{}} = Bids.update_bid(bid, @invalid_attrs)
      assert bid == Bids.get_bid!(bid.id)
    end

    test "delete_bid/1 deletes the bid" do
      bid = bid_fixture()
      assert {:ok, %Bid{}} = Bids.delete_bid(bid)
      assert_raise Ecto.NoResultsError, fn -> Bids.get_bid!(bid.id) end
    end

    test "change_bid/1 returns a bid changeset" do
      bid = bid_fixture()
      assert %Ecto.Changeset{} = Bids.change_bid(bid)
    end
  end
end
