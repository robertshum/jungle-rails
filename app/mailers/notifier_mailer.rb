class NotifierMailer < ApplicationMailer
  default from: 'plant@lover.com'
  def send_order_conf(current_user, order_details)

    # made available to the view
    @current_user = current_user
    @order_details = order_details

    mail(
      to: current_user.email,
      subject: "Your Plant Order Summary, #{current_user.first_name} 🌱"
    )
  end
end
