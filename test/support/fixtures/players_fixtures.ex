defmodule SSAuction.PlayersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SSAuction.Players` context.
  """

  @doc """
  Generate a all_player.
  """
  def all_player_fixture(attrs \\ %{}) do
    {:ok, all_player} =
      attrs
      |> Enum.into(%{
        name: "some name",
        position: "some position",
        ssnum: 42,
        year_range: "some year_range"
      })
      |> SSAuction.Players.create_all_player()

    all_player
  end
end
