defmodule SSAuction.TeamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SSAuction.Teams` context.
  """

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: "some name",
        new_nominations_open_at: ~U[2021-12-27 21:29:00Z],
        time_nominations_expire: ~U[2021-12-27 21:29:00Z],
        unused_nominations: 42
      })
      |> SSAuction.Teams.create_team()

    team
  end
end
