defmodule SSAuction.Repo do
  use Ecto.Repo,
    otp_app: :ssauction_live,
    adapter: Ecto.Adapters.Postgres
end
