# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SSAuction.Repo.insert!(%SSAuction.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SSAuction.Repo
alias SSAuction.Accounts.User
alias SSAuction.Accounts

# reset all user passwords
password_to_reset_to = "secret"
Enum.map(Repo.all(User),
         fn user -> Accounts.reset_user_password(user,
                                                 %{password: password_to_reset_to,
                                                   password_confirmation: password_to_reset_to})
         end)
