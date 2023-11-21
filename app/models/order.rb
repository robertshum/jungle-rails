class Order < ApplicationRecord
  
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create -> { deduct_stock(line_items) }

  private

  def deduct_stock(line_items)
    line_items.each do |line_item|
      product = line_item.product
      product.quantity -= line_item.quantity
      product.save
    end
  end
end
