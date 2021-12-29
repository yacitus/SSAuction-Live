defmodule SSAuction.Players.RosteredPlayer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rostered_players" do
    field :cost, :integer
  end

  def changeset(rostered_player, params \\ %{}) do
    required_fields = [:cost]

    rostered_player
    |> cast(params, required_fields)
    |> validate_required(required_fields)
  end
end
