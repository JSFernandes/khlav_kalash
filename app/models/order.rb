class Order < ApplicationRecord
  before_create :set_defaults

  validates :first_name, presence: true
  validates :country, presence: true
  validates :postal_code, presence: true
  validates :email_address, presence: true, email: true

  UNIT_PRICE_CENTS = 299
  CURRENCY = 'USD'.freeze

  def price
    Money.new(UNIT_PRICE_CENTS, CURRENCY)
  end

  def customer_billing_info
    {
      receipt_email: email_address,
      shipping: {
        name: [first_name, last_name].compact.join(" "),
        address: {
          line1: street_line_1,
          city: city,
          country: country,
          line2: street_line_2,
          postal_code: postal_code,
          state: region,
        },
      },
    }
  end

  private

  def set_defaults
    self.number = next_number
    self.permalink = SecureRandom.hex(20)

    while Order.where(permalink: self.permalink).any?
      self.permalink = SecureRandom.hex(20)
    end
  end

  def next_number
    current = self.class.reorder('number desc').first.try(:number) || '000000000000'
    current.next
  end
end
