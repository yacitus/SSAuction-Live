defmodule SSAuction.Repo.Migrations.ModifyUsersTable do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    alter table(:users) do
      modify :email, :citext
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
