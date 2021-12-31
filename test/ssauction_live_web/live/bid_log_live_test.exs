defmodule SSAuctionWeb.BidLogLiveTest do
  use SSAuctionWeb.ConnCase

  import Phoenix.LiveViewTest
  import SSAuction.BidsFixtures

  @create_attrs %{amount: 42, datetime: %{day: 30, hour: 14, minute: 45, month: 12, year: 2021}, type: "some type"}
  @update_attrs %{amount: 43, datetime: %{day: 31, hour: 14, minute: 45, month: 12, year: 2021}, type: "some updated type"}
  @invalid_attrs %{amount: nil, datetime: %{day: 30, hour: 14, minute: 45, month: 2, year: 2021}, type: nil}

  defp create_bid_log(_) do
    bid_log = bid_log_fixture()
    %{bid_log: bid_log}
  end

  describe "Index" do
    setup [:create_bid_log]

    test "lists all bid_logs", %{conn: conn, bid_log: bid_log} do
      {:ok, _index_live, html} = live(conn, Routes.bid_log_index_path(conn, :index))

      assert html =~ "Listing Bid logs"
      assert html =~ bid_log.type
    end

    test "saves new bid_log", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bid_log_index_path(conn, :index))

      assert index_live |> element("a", "New Bid log") |> render_click() =~
               "New Bid log"

      assert_patch(index_live, Routes.bid_log_index_path(conn, :new))

      assert index_live
             |> form("#bid_log-form", bid_log: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#bid_log-form", bid_log: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bid_log_index_path(conn, :index))

      assert html =~ "Bid log created successfully"
      assert html =~ "some type"
    end

    test "updates bid_log in listing", %{conn: conn, bid_log: bid_log} do
      {:ok, index_live, _html} = live(conn, Routes.bid_log_index_path(conn, :index))

      assert index_live |> element("#bid_log-#{bid_log.id} a", "Edit") |> render_click() =~
               "Edit Bid log"

      assert_patch(index_live, Routes.bid_log_index_path(conn, :edit, bid_log))

      assert index_live
             |> form("#bid_log-form", bid_log: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#bid_log-form", bid_log: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bid_log_index_path(conn, :index))

      assert html =~ "Bid log updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes bid_log in listing", %{conn: conn, bid_log: bid_log} do
      {:ok, index_live, _html} = live(conn, Routes.bid_log_index_path(conn, :index))

      assert index_live |> element("#bid_log-#{bid_log.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bid_log-#{bid_log.id}")
    end
  end

  describe "Show" do
    setup [:create_bid_log]

    test "displays bid_log", %{conn: conn, bid_log: bid_log} do
      {:ok, _show_live, html} = live(conn, Routes.bid_log_show_path(conn, :show, bid_log))

      assert html =~ "Show Bid log"
      assert html =~ bid_log.type
    end

    test "updates bid_log within modal", %{conn: conn, bid_log: bid_log} do
      {:ok, show_live, _html} = live(conn, Routes.bid_log_show_path(conn, :show, bid_log))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bid log"

      assert_patch(show_live, Routes.bid_log_show_path(conn, :edit, bid_log))

      assert show_live
             |> form("#bid_log-form", bid_log: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#bid_log-form", bid_log: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bid_log_show_path(conn, :show, bid_log))

      assert html =~ "Bid log updated successfully"
      assert html =~ "some updated type"
    end
  end
end
