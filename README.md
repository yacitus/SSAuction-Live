# SSAuction-Live

## TODO:

* rename SSAuction.Bids.bid_logs to SSAuction.Bids.list_bid_logs
* HEADER!
* figure out how to dedupe team_live/bids.html.heex and auction_live/bids.html.heex
* Teams Table on auction page: hide Time Nominations Expire and New Nominations Open At columns if there are no unused nominations
* move Rostered Players table on team & auction pages to separate pages
* make Rostered Players table on team & auction pages sortable, add column for datetime rostered
* Auto-Nomination Queue page: show Nominations Per Team
* Auto-Nomination Queue page: highlight top N players where N = Nominations Per Team

## Phoenix

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
