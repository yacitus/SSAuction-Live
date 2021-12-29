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

  describe "players" do
    alias SSAuction.Players.Player

    import SSAuction.PlayersFixtures

    @invalid_attrs %{name: nil, position: nil, ssnum: nil, year_range: nil}

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Players.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Players.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      valid_attrs = %{name: "some name", position: "some position", ssnum: 42, year_range: "some year_range"}

      assert {:ok, %Player{} = player} = Players.create_player(valid_attrs)
      assert player.name == "some name"
      assert player.position == "some position"
      assert player.ssnum == 42
      assert player.year_range == "some year_range"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Players.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      update_attrs = %{name: "some updated name", position: "some updated position", ssnum: 43, year_range: "some updated year_range"}

      assert {:ok, %Player{} = player} = Players.update_player(player, update_attrs)
      assert player.name == "some updated name"
      assert player.position == "some updated position"
      assert player.ssnum == 43
      assert player.year_range == "some updated year_range"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Players.update_player(player, @invalid_attrs)
      assert player == Players.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Players.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Players.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Players.change_player(player)
    end
  end

  describe "rostered_players" do
    alias SSAuction.Players.RosteredPlayer

    import SSAuction.PlayersFixtures

    @invalid_attrs %{cost: nil}

    test "list_rostered_players/0 returns all rostered_players" do
      rostered_player = rostered_player_fixture()
      assert Players.list_rostered_players() == [rostered_player]
    end

    test "get_rostered_player!/1 returns the rostered_player with given id" do
      rostered_player = rostered_player_fixture()
      assert Players.get_rostered_player!(rostered_player.id) == rostered_player
    end

    test "create_rostered_player/1 with valid data creates a rostered_player" do
      valid_attrs = %{cost: 42}

      assert {:ok, %RosteredPlayer{} = rostered_player} = Players.create_rostered_player(valid_attrs)
      assert rostered_player.cost == 42
    end

    test "create_rostered_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Players.create_rostered_player(@invalid_attrs)
    end

    test "update_rostered_player/2 with valid data updates the rostered_player" do
      rostered_player = rostered_player_fixture()
      update_attrs = %{cost: 43}

      assert {:ok, %RosteredPlayer{} = rostered_player} = Players.update_rostered_player(rostered_player, update_attrs)
      assert rostered_player.cost == 43
    end

    test "update_rostered_player/2 with invalid data returns error changeset" do
      rostered_player = rostered_player_fixture()
      assert {:error, %Ecto.Changeset{}} = Players.update_rostered_player(rostered_player, @invalid_attrs)
      assert rostered_player == Players.get_rostered_player!(rostered_player.id)
    end

    test "delete_rostered_player/1 deletes the rostered_player" do
      rostered_player = rostered_player_fixture()
      assert {:ok, %RosteredPlayer{}} = Players.delete_rostered_player(rostered_player)
      assert_raise Ecto.NoResultsError, fn -> Players.get_rostered_player!(rostered_player.id) end
    end

    test "change_rostered_player/1 returns a rostered_player changeset" do
      rostered_player = rostered_player_fixture()
      assert %Ecto.Changeset{} = Players.change_rostered_player(rostered_player)
    end
  end
end
