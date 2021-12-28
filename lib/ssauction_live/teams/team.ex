defmodule SSAuction.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    field :new_nominations_open_at, :utc_datetime
    field :time_nominations_expire, :utc_datetime
    field :unused_nominations, :integer

    belongs_to :auction, SSAuction.Auctions.Auction

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :unused_nominations, :time_nominations_expire, :new_nominations_open_at])
    |> validate_required([:name, :unused_nominations, :time_nominations_expire, :new_nominations_open_at])
  end
end
