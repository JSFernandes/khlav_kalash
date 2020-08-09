class PaymentsController < ApplicationController
  def new
    redirect_to new_order_url unless params[:order_number]

    @order = Order.find_by(number: params[:order_number])
    @payment_intent = Stripe::PaymentIntent.create(
      amount: Order::UNIT_PRICE_CENTS,
      currency: "usd",
      payment_method_types: ["card"],
      **@order.customer_billing_info,
    )
    PaymentIntent.create(order: @order, stripe_id: @payment_intent.id)
  end
end
