defmodule SSAuctionWeb.AllPlayerLiveTest do
  use SSAuctionWeb.ConnCase

  import Phoenix.LiveViewTest
  import SSAuction.PlayersFixtures

  @create_attrs %{name: "some name", position: "some position", ssnum: 42, year_range: "some year_range"}
  @update_attrs %{name: "some updated name", position: "some updated position", ssnum: 43, year_range: "some updated year_range"}
  @invalid_attrs %{name: nil, position: nil, ssnum: nil, year_range: nil}

  defp create_all_player(_) do
    all_player = all_player_fixture()
    %{all_player: all_player}
  end

  describe "Index" do
    setup [:create_all_player]

    test "lists all all_players", %{conn: conn, all_player: all_player} do
      {:ok, _index_live, html} = live(conn, Routes.all_player_index_path(conn, :index))

      assert html =~ "Listing All players"
      assert html =~ all_player.name
    end

    test "saves new all_player", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.all_player_index_path(conn, :index))

      assert index_live |> element("a", "New All player") |> render_click() =~
               "New All player"

      assert_patch(index_live, Routes.all_player_index_path(conn, :new))

      assert index_live
             |> form("#all_player-form", all_player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#all_player-form", all_player: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.all_player_index_path(conn, :index))

      assert html =~ "All player created successfully"
      assert html =~ "some name"
    end

    test "updates all_player in listing", %{conn: conn, all_player: all_player} do
      {:ok, index_live, _html} = live(conn, Routes.all_player_index_path(conn, :index))

      assert index_live |> element("#all_player-#{all_player.id} a", "Edit") |> render_click() =~
               "Edit All player"

      assert_patch(index_live, Routes.all_player_index_path(conn, :edit, all_player))

      assert index_live
             |> form("#all_player-form", all_player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#all_player-form", all_player: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.all_player_index_path(conn, :index))

      assert html =~ "All player updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes all_player in listing", %{conn: conn, all_player: all_player} do
      {:ok, index_live, _html} = live(conn, Routes.all_player_index_path(conn, :index))

      assert index_live |> element("#all_player-#{all_player.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#all_player-#{all_player.id}")
    end
  end

  describe "Show" do
    setup [:create_all_player]

    test "displays all_player", %{conn: conn, all_player: all_player} do
      {:ok, _show_live, html} = live(conn, Routes.all_player_show_path(conn, :show, all_player))

      assert html =~ "Show All player"
      assert html =~ all_player.name
    end

    test "updates all_player within modal", %{conn: conn, all_player: all_player} do
      {:ok, show_live, _html} = live(conn, Routes.all_player_show_path(conn, :show, all_player))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit All player"

      assert_patch(show_live, Routes.all_player_show_path(conn, :edit, all_player))

      assert show_live
             |> form("#all_player-form", all_player: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#all_player-form", all_player: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.all_player_show_path(conn, :show, all_player))

      assert html =~ "All player updated successfully"
      assert html =~ "some updated name"
    end
  end
end
