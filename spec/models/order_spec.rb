require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:category) { Category.create(name: 'Test Category') }
  let(:image) {
    Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/app/assets/images/plants.jpg')))
  }
  let(:stripe_charge_id) {"test_stripe_charge_id"}

  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @product1 = Product.new(
          name: 'Jungle Tree 1',
          price_cents: 1100,
          quantity: 5,
          category: category,
          image: image
        )

      @product2 = Product.new(
        name: 'Bushy Bush 1',
        price_cents: 2100,
        quantity: 3,
        category: category,
        image: image
      )

      # Setup at least one product that will NOT be in the order
      @product3 = Product.new(
        name: 'Spikey Mikey 1',
        price_cents: 500,
        quantity: 4,
        category: category,
        image: image
      )

      # manually save this.  For product 1 and 2, it seems to get saved when referenced in an order.line_item.
      @product3.save
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do

      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(stripe_charge_id: stripe_charge_id)
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 5,
        item_price: @product1.price,
        total_price: @product1.price * 5
      )

      @order.line_items.new(
        product: @product2,
        quantity: 1,
        item_price: @product2.price,
        total_price: @product2.price * 1
      )
      
      # doesn't matter for this test
      @order.total_cents = 9999
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      @product3.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to be(0)
      expect(@product2.quantity).to be(2)
    end

    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(stripe_charge_id: stripe_charge_id)
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 5,
        item_price: @product1.price,
        total_price: @product1.price * 5
      )

      @order.line_items.new(
        product: @product2,
        quantity: 1,
        item_price: @product2.price,
        total_price: @product2.price * 1
      )
      
      # doesn't matter for this test
      @order.total_cents = 9999
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product3.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product3.quantity).to be(4)
    end
  end
end