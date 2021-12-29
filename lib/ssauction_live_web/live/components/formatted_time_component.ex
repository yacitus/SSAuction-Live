defmodule SSAuctionWeb.FormattedTimeComponent do
  use SSAuctionWeb, :live_component

  alias SSAuction.Cldr

  def render(assigns) do
    ~H"""
      <%= if connected?(@socket) do
            Cldr.format_time(@utc_datetime,
                             locale: @locale,
                             timezone: @timezone)
          else
            Cldr.format_time(@utc_datetime)
          end
      %>
    """
  end
end
