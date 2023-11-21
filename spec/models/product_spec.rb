require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    let(:category) { Category.create(name: 'Test Category') }
    let(:image) {
      Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/app/assets/images/plants.jpg')))
    }

    context 'create product with all fields filled' do

      # memoize helper method 'let'.  When 'category' is referenced,
      # it will return the Category.create...
      # Rack::Test::UploadedFile used to simulate an upload
      it 'returns a product with no errors' do
        product = Product.new(
          name: 'Test Product',
          price_cents: 1100,
          quantity: 5,
          category: category,
          image: image
        )

        # this checks for all model validations
        expect(product).to be_valid
      end
    end

    context 'fail to create a product with no name' do

      it 'give an error, when given no name' do
        product = Product.new(
          name: nil,
          price_cents: 1100,
          quantity: 5,
          category: category,
          image: image
        )

        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include("Name can't be blank")
      end
    end

    context 'fail to create a product with no price' do
      it 'give an error, when given no price' do
        product = Product.new(
          name: 'Test Product',
          price_cents: nil,
          quantity: 5,
          category: category,
          image: image
        )
        
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include("Price can't be blank")
      end
    end

    context 'fail to create a product with no quantity' do
      it 'give an error, when given no quantity' do
        product = Product.new(
          name: 'Test Product',
          price_cents: 1100,
          quantity: nil,
          category: category,
          image: image
        )
        
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    context 'fail to create a product with no category' do
      it 'give an error, when given no category' do
        product = Product.new(
          name: 'Test Product',
          price_cents: 1100,
          quantity: 5,
          category: nil,
          image: image
        )
        
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include("Category can't be blank")
      end
    end

    context 'fail to create a product with no image' do
      it 'give an error, when given no image' do
        product = Product.new(
          name: 'Test Product',
          price_cents: 1100,
          quantity: 5,
          category: category,
          image: nil
        )
        
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include("Image can't be blank")
      end
    end

  end
end
