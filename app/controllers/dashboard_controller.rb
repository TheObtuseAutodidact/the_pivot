class DashboardController < ApplicationController

  def index
    @store = Store.find_by_slug(params["store_slug"])
    @orders = @store.orders
    @store_items = @store.items.where(active: true)
  end
end
