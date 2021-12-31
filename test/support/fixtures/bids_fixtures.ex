defmodule SSAuction.BidsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SSAuction.Bids` context.
  """

  @doc """
  Generate a bid_log.
  """
  def bid_log_fixture(attrs \\ %{}) do
    {:ok, bid_log} =
      attrs
      |> Enum.into(%{
        amount: 42,
        datetime: ~U[2021-12-30 14:45:00Z],
        type: "some type"
      })
      |> SSAuction.Bids.create_bid_log()

    bid_log
  end
end
