defmodule SSAuction.TeamsTest do
  use SSAuction.DataCase

  alias SSAuction.Teams

  describe "teams" do
    alias SSAuction.Teams.Team

    import SSAuction.TeamsFixtures

    @invalid_attrs %{name: nil, new_nominations_open_at: nil, time_nominations_expire: nil, unused_nominations: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Teams.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Teams.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{name: "some name", new_nominations_open_at: ~U[2021-12-27 21:29:00Z], time_nominations_expire: ~U[2021-12-27 21:29:00Z], unused_nominations: 42}

      assert {:ok, %Team{} = team} = Teams.create_team(valid_attrs)
      assert team.name == "some name"
      assert team.new_nominations_open_at == ~U[2021-12-27 21:29:00Z]
      assert team.time_nominations_expire == ~U[2021-12-27 21:29:00Z]
      assert team.unused_nominations == 42
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Teams.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{name: "some updated name", new_nominations_open_at: ~U[2021-12-28 21:29:00Z], time_nominations_expire: ~U[2021-12-28 21:29:00Z], unused_nominations: 43}

      assert {:ok, %Team{} = team} = Teams.update_team(team, update_attrs)
      assert team.name == "some updated name"
      assert team.new_nominations_open_at == ~U[2021-12-28 21:29:00Z]
      assert team.time_nominations_expire == ~U[2021-12-28 21:29:00Z]
      assert team.unused_nominations == 43
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Teams.update_team(team, @invalid_attrs)
      assert team == Teams.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Teams.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Teams.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Teams.change_team(team)
    end
  end
end
