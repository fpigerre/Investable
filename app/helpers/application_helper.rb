module ApplicationHelper
  # Returns appropriate link to follow or stop following a stock
  def follow_link(stock)
    if current_user.watching? stock
      link_to(unwatch_stock_path(stock), :method => :post, :remote => true, :class => 'btn btn-default rounded-corners') do
        '<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>'.html_safe + ' Stop Watching'
      end
    else
      link_to(watch_stock_path(stock), :method => :post, :remote => true, :class => 'btn btn-default rounded-corners') do
        '<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>'.html_safe + ' Watch Stock'
      end
    end
  end
end
