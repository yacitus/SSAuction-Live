defmodule SSAuction.PlayersTest do
  use SSAuction.DataCase

  alias SSAuction.Players

  describe "all_players" do
    alias SSAuction.Players.AllPlayer

    import SSAuction.PlayersFixtures

    @invalid_attrs %{name: nil, position: nil, ssnum: nil, year_range: nil}

    test "list_all_players/0 returns all all_players" do
      all_player = all_player_fixture()
      assert Players.list_all_players() == [all_player]
    end

    test "get_all_player!/1 returns the all_player with given id" do
      all_player = all_player_fixture()
      assert Players.get_all_player!(all_player.id) == all_player
    end

    test "create_all_player/1 with valid data creates a all_player" do
      valid_attrs = %{name: "some name", position: "some position", ssnum: 42, year_range: "some year_range"}

      assert {:ok, %AllPlayer{} = all_player} = Players.create_all_player(valid_attrs)
      assert all_player.name == "some name"
      assert all_player.position == "some position"
      assert all_player.ssnum == 42
      assert all_player.year_range == "some year_range"
    end

    test "create_all_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Players.create_all_player(@invalid_attrs)
    end

    test "update_all_player/2 with valid data updates the all_player" do
      all_player = all_player_fixture()
      update_attrs = %{name: "some updated name", position: "some updated position", ssnum: 43, year_range: "some updated year_range"}

      assert {:ok, %AllPlayer{} = all_player} = Players.update_all_player(all_player, update_attrs)
      assert all_player.name == "some updated name"
      assert all_player.position == "some updated position"
      assert all_player.ssnum == 43
      assert all_player.year_range == "some updated year_range"
    end

    test "update_all_player/2 with invalid data returns error changeset" do
      all_player = all_player_fixture()
      assert {:error, %Ecto.Changeset{}} = Players.update_all_player(all_player, @invalid_attrs)
      assert all_player == Players.get_all_player!(all_player.id)
    end

    test "delete_all_player/1 deletes the all_player" do
      all_player = all_player_fixture()
      assert {:ok, %AllPlayer{}} = Players.delete_all_player(all_player)
      assert_raise Ecto.NoResultsError, fn -> Players.get_all_player!(all_player.id) end
    end

    test "change_all_player/1 returns a all_player changeset" do
      all_player = all_player_fixture()
      assert %Ecto.Changeset{} = Players.change_all_player(all_player)
    end
  end
end
