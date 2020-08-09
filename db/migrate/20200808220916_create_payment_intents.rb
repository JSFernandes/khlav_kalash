class CreatePaymentIntents < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_intents do |t|
      t.integer :order_id
      t.string :stripe_id
    end
  end
end
