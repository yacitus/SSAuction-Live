defmodule SSAuction.Repo.Migrations.RenamePasswordHash do
  use Ecto.Migration

  def change do
    rename table("users"), :password_hash, to: :hashed_password
  end
end
