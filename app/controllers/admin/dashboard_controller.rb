class Admin::DashboardController < ApplicationController

  # basic http authentication
  include AuthenticationConcern

  def show
    @product_count = Product.count
    @category_count = Category.count

    # starting out, we have no orders, so default it to 0  If we try to divide 0 by 100 in the form it wil throw an error.
    @avg_order_amount = Order.average("total_cents") || 0
    @max_order_amount = Order.maximum("total_cents") || 0
    @min_order_amount = Order.minimum("total_cents") || 0
  end
end
