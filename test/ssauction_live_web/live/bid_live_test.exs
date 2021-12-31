defmodule SSAuctionWeb.BidLiveTest do
  use SSAuctionWeb.ConnCase

  import Phoenix.LiveViewTest
  import SSAuction.BidsFixtures

  @create_attrs %{bid_amount: 42, closed: true, expires_at: %{day: 30, hour: 15, minute: 27, month: 12, year: 2021}, hidden_high_bid: 42, nominated_by: 42}
  @update_attrs %{bid_amount: 43, closed: false, expires_at: %{day: 31, hour: 15, minute: 27, month: 12, year: 2021}, hidden_high_bid: 43, nominated_by: 43}
  @invalid_attrs %{bid_amount: nil, closed: false, expires_at: %{day: 30, hour: 15, minute: 27, month: 2, year: 2021}, hidden_high_bid: nil, nominated_by: nil}

  defp create_bid(_) do
    bid = bid_fixture()
    %{bid: bid}
  end

  describe "Index" do
    setup [:create_bid]

    test "lists all bids", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.bid_index_path(conn, :index))

      assert html =~ "Listing Bids"
    end

    test "saves new bid", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bid_index_path(conn, :index))

      assert index_live |> element("a", "New Bid") |> render_click() =~
               "New Bid"

      assert_patch(index_live, Routes.bid_index_path(conn, :new))

      assert index_live
             |> form("#bid-form", bid: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#bid-form", bid: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bid_index_path(conn, :index))

      assert html =~ "Bid created successfully"
    end

    test "updates bid in listing", %{conn: conn, bid: bid} do
      {:ok, index_live, _html} = live(conn, Routes.bid_index_path(conn, :index))

      assert index_live |> element("#bid-#{bid.id} a", "Edit") |> render_click() =~
               "Edit Bid"

      assert_patch(index_live, Routes.bid_index_path(conn, :edit, bid))

      assert index_live
             |> form("#bid-form", bid: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#bid-form", bid: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bid_index_path(conn, :index))

      assert html =~ "Bid updated successfully"
    end

    test "deletes bid in listing", %{conn: conn, bid: bid} do
      {:ok, index_live, _html} = live(conn, Routes.bid_index_path(conn, :index))

      assert index_live |> element("#bid-#{bid.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bid-#{bid.id}")
    end
  end

  describe "Show" do
    setup [:create_bid]

    test "displays bid", %{conn: conn, bid: bid} do
      {:ok, _show_live, html} = live(conn, Routes.bid_show_path(conn, :show, bid))

      assert html =~ "Show Bid"
    end

    test "updates bid within modal", %{conn: conn, bid: bid} do
      {:ok, show_live, _html} = live(conn, Routes.bid_show_path(conn, :show, bid))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bid"

      assert_patch(show_live, Routes.bid_show_path(conn, :edit, bid))

      assert show_live
             |> form("#bid-form", bid: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#bid-form", bid: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bid_show_path(conn, :show, bid))

      assert html =~ "Bid updated successfully"
    end
  end
end
