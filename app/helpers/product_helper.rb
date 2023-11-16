module ProductHelper

  def empty_stock? product
    product.quantity == 0
  end
end
