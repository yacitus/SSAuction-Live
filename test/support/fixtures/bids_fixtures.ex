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

  @doc """
  Generate a bid.
  """
  def bid_fixture(attrs \\ %{}) do
    {:ok, bid} =
      attrs
      |> Enum.into(%{
        bid_amount: 42,
        closed: true,
        expires_at: ~U[2021-12-30 15:27:00Z],
        hidden_high_bid: 42,
        nominated_by: 42
      })
      |> SSAuction.Bids.create_bid()

    bid
  end
end
