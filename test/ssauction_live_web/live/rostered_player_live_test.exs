defmodule SSAuctionWeb.RosteredPlayerLiveTest do
  use SSAuctionWeb.ConnCase

  import Phoenix.LiveViewTest
  import SSAuction.PlayersFixtures

  @create_attrs %{cost: 42}
  @update_attrs %{cost: 43}
  @invalid_attrs %{cost: nil}

  defp create_rostered_player(_) do
    rostered_player = rostered_player_fixture()
    %{rostered_player: rostered_player}
  end

  describe "Index" do
    setup [:create_rostered_player]

    test "lists all rostered_players", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.rostered_player_index_path(conn, :index))

      assert html =~ "Listing Rostered players"
    end

    test "saves new rostered_player", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.rostered_player_index_path(conn, :index))

      assert index_live |> element("a", "New Rostered player") |> render_click() =~
               "New Rostered player"

      assert_patch(index_live, Routes.rostered_player_index_path(conn, :new))

      assert index_live
             |> form("#rostered_player-form", rostered_player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rostered_player-form", rostered_player: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rostered_player_index_path(conn, :index))

      assert html =~ "Rostered player created successfully"
    end

    test "updates rostered_player in listing", %{conn: conn, rostered_player: rostered_player} do
      {:ok, index_live, _html} = live(conn, Routes.rostered_player_index_path(conn, :index))

      assert index_live |> element("#rostered_player-#{rostered_player.id} a", "Edit") |> render_click() =~
               "Edit Rostered player"

      assert_patch(index_live, Routes.rostered_player_index_path(conn, :edit, rostered_player))

      assert index_live
             |> form("#rostered_player-form", rostered_player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rostered_player-form", rostered_player: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rostered_player_index_path(conn, :index))

      assert html =~ "Rostered player updated successfully"
    end

    test "deletes rostered_player in listing", %{conn: conn, rostered_player: rostered_player} do
      {:ok, index_live, _html} = live(conn, Routes.rostered_player_index_path(conn, :index))

      assert index_live |> element("#rostered_player-#{rostered_player.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#rostered_player-#{rostered_player.id}")
    end
  end

  describe "Show" do
    setup [:create_rostered_player]

    test "displays rostered_player", %{conn: conn, rostered_player: rostered_player} do
      {:ok, _show_live, html} = live(conn, Routes.rostered_player_show_path(conn, :show, rostered_player))

      assert html =~ "Show Rostered player"
    end

    test "updates rostered_player within modal", %{conn: conn, rostered_player: rostered_player} do
      {:ok, show_live, _html} = live(conn, Routes.rostered_player_show_path(conn, :show, rostered_player))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Rostered player"

      assert_patch(show_live, Routes.rostered_player_show_path(conn, :edit, rostered_player))

      assert show_live
             |> form("#rostered_player-form", rostered_player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#rostered_player-form", rostered_player: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rostered_player_show_path(conn, :show, rostered_player))

      assert html =~ "Rostered player updated successfully"
    end
  end
end
