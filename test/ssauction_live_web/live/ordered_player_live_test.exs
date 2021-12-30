defmodule SSAuctionWeb.OrderedPlayerLiveTest do
  use SSAuctionWeb.ConnCase

  import Phoenix.LiveViewTest
  import SSAuction.PlayersFixtures

  @create_attrs %{rank: 42}
  @update_attrs %{rank: 43}
  @invalid_attrs %{rank: nil}

  defp create_ordered_player(_) do
    ordered_player = ordered_player_fixture()
    %{ordered_player: ordered_player}
  end

  describe "Index" do
    setup [:create_ordered_player]

    test "lists all ordered_players", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.ordered_player_index_path(conn, :index))

      assert html =~ "Listing Ordered players"
    end

    test "saves new ordered_player", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.ordered_player_index_path(conn, :index))

      assert index_live |> element("a", "New Ordered player") |> render_click() =~
               "New Ordered player"

      assert_patch(index_live, Routes.ordered_player_index_path(conn, :new))

      assert index_live
             |> form("#ordered_player-form", ordered_player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ordered_player-form", ordered_player: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ordered_player_index_path(conn, :index))

      assert html =~ "Ordered player created successfully"
    end

    test "updates ordered_player in listing", %{conn: conn, ordered_player: ordered_player} do
      {:ok, index_live, _html} = live(conn, Routes.ordered_player_index_path(conn, :index))

      assert index_live |> element("#ordered_player-#{ordered_player.id} a", "Edit") |> render_click() =~
               "Edit Ordered player"

      assert_patch(index_live, Routes.ordered_player_index_path(conn, :edit, ordered_player))

      assert index_live
             |> form("#ordered_player-form", ordered_player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ordered_player-form", ordered_player: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ordered_player_index_path(conn, :index))

      assert html =~ "Ordered player updated successfully"
    end

    test "deletes ordered_player in listing", %{conn: conn, ordered_player: ordered_player} do
      {:ok, index_live, _html} = live(conn, Routes.ordered_player_index_path(conn, :index))

      assert index_live |> element("#ordered_player-#{ordered_player.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#ordered_player-#{ordered_player.id}")
    end
  end

  describe "Show" do
    setup [:create_ordered_player]

    test "displays ordered_player", %{conn: conn, ordered_player: ordered_player} do
      {:ok, _show_live, html} = live(conn, Routes.ordered_player_show_path(conn, :show, ordered_player))

      assert html =~ "Show Ordered player"
    end

    test "updates ordered_player within modal", %{conn: conn, ordered_player: ordered_player} do
      {:ok, show_live, _html} = live(conn, Routes.ordered_player_show_path(conn, :show, ordered_player))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ordered player"

      assert_patch(show_live, Routes.ordered_player_show_path(conn, :edit, ordered_player))

      assert show_live
             |> form("#ordered_player-form", ordered_player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#ordered_player-form", ordered_player: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ordered_player_show_path(conn, :show, ordered_player))

      assert html =~ "Ordered player updated successfully"
    end
  end
end
