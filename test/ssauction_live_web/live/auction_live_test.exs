defmodule SSAuctionWeb.AuctionLiveTest do
  use SSAuctionWeb.ConnCase

  import Phoenix.LiveViewTest
  import SSAuction.AuctionsFixtures

  @create_attrs %{active: true, bid_timeout_seconds: 42, initial_bid_timeout_seconds: 42, must_roster_all_players: true, name: "some name", new_nominations_created: "some new_nominations_created", nominations_per_team: 42, players_per_team: 42, seconds_before_autonomination: 42, started_or_paused_at: %{day: 19, hour: 3, minute: 52, month: 12, year: 2021}, team_dollars_per_player: 42, year_range: "some year_range"}
  @update_attrs %{active: false, bid_timeout_seconds: 43, initial_bid_timeout_seconds: 43, must_roster_all_players: false, name: "some updated name", new_nominations_created: "some updated new_nominations_created", nominations_per_team: 43, players_per_team: 43, seconds_before_autonomination: 43, started_or_paused_at: %{day: 20, hour: 3, minute: 52, month: 12, year: 2021}, team_dollars_per_player: 43, year_range: "some updated year_range"}
  @invalid_attrs %{active: false, bid_timeout_seconds: nil, initial_bid_timeout_seconds: nil, must_roster_all_players: false, name: nil, new_nominations_created: nil, nominations_per_team: nil, players_per_team: nil, seconds_before_autonomination: nil, started_or_paused_at: %{day: 30, hour: 3, minute: 52, month: 2, year: 2021}, team_dollars_per_player: nil, year_range: nil}

  defp create_auction(_) do
    auction = auction_fixture()
    %{auction: auction}
  end

  describe "Index" do
    setup [:create_auction]

    test "lists all auctions", %{conn: conn, auction: auction} do
      {:ok, _index_live, html} = live(conn, Routes.auction_index_path(conn, :index))

      assert html =~ "Listing Auctions"
      assert html =~ auction.name
    end

    test "saves new auction", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.auction_index_path(conn, :index))

      assert index_live |> element("a", "New Auction") |> render_click() =~
               "New Auction"

      assert_patch(index_live, Routes.auction_index_path(conn, :new))

      assert index_live
             |> form("#auction-form", auction: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#auction-form", auction: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.auction_index_path(conn, :index))

      assert html =~ "Auction created successfully"
      assert html =~ "some name"
    end

    test "updates auction in listing", %{conn: conn, auction: auction} do
      {:ok, index_live, _html} = live(conn, Routes.auction_index_path(conn, :index))

      assert index_live |> element("#auction-#{auction.id} a", "Edit") |> render_click() =~
               "Edit Auction"

      assert_patch(index_live, Routes.auction_index_path(conn, :edit, auction))

      assert index_live
             |> form("#auction-form", auction: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#auction-form", auction: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.auction_index_path(conn, :index))

      assert html =~ "Auction updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes auction in listing", %{conn: conn, auction: auction} do
      {:ok, index_live, _html} = live(conn, Routes.auction_index_path(conn, :index))

      assert index_live |> element("#auction-#{auction.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#auction-#{auction.id}")
    end
  end

  describe "Show" do
    setup [:create_auction]

    test "displays auction", %{conn: conn, auction: auction} do
      {:ok, _show_live, html} = live(conn, Routes.auction_show_path(conn, :show, auction))

      assert html =~ "Show Auction"
      assert html =~ auction.name
    end

    test "updates auction within modal", %{conn: conn, auction: auction} do
      {:ok, show_live, _html} = live(conn, Routes.auction_show_path(conn, :show, auction))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Auction"

      assert_patch(show_live, Routes.auction_show_path(conn, :edit, auction))

      assert show_live
             |> form("#auction-form", auction: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#auction-form", auction: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.auction_show_path(conn, :show, auction))

      assert html =~ "Auction updated successfully"
      assert html =~ "some updated name"
    end
  end
end
