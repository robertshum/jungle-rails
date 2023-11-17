class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])

    # Gets line items from AR where the order id matches
    @line_items = LineItem.where(order_id: params[:id])
  end

def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  # stripe has already processed. Safe to send email
  def create_order(stripe_charge)

    order_details = []

    # going through each cart and creating a order details for email
    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
    
      order_details << {
        product: product.name,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      }
    end

    user_email = 'Guest (no email)'
    if current_user
      user_email = current_user.email
      notifier_mailer = NotifierMailer.send_order_conf(current_user, order_details)
      notifier_mailer.deliver_now
      puts 'delivering mail now'
    end

    order = Order.new(
      email: user_email,
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

end
