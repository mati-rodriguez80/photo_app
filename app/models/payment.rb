class Payment < ApplicationRecord
  belongs_to :user
  attr_accessor :card_number, :card_cvc, :card_expires_month, :card_expires_year

  # Returns array like this: [["1-January", 1], [...], ....], to be used in options for select
  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map { |name, index| ["#{index+1}-#{name}", index+1] }
  end

  # Returns array like this: [2022, 2023, ..., 2032], to be used in options for select
  def self.year_options
    (Date.today.year..(Date.today.year+10)).to_a
  end

  # According to Stripe docs (legacy), creates the actual charges by calling the Stripe API
  def process_payment
    # Amount in cents
    amount = 1000

    customer = Stripe::Customer.create(
      email: email,
      card: token
    )

    Stripe::Charge.create(
      customer: customer.id,
      amount: amount,
      description: 'Premium Plan',
      currency: 'usd'
    )
  end
end
