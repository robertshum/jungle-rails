class Admin::DashboardController < ApplicationController

  # basic http authentication
  include AuthenticationConcern

  def show
    @product_count = Product.count
    @category_count = Category.count
    @avg_order_amount = Order.average("total_cents")
    @max_order_amount = Order.maximum("total_cents")
    @min_order_amount = Order.minimum("total_cents")
  end
end
