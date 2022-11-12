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
  def process_payment(plan)
    # Amount in cents
    if plan == 'premium'
      amount = 1000
      description = 'Premium Plan'
    elsif plan == 'amaze'
      amount = 2000
      description = 'Amaze Plan'
    end

    customer = Stripe::Customer.create(
      email: email,
      card: token
    )

    Stripe::Charge.create(
      customer: customer.id,
      amount: amount,
      description: description,
      currency: 'usd'
    )
  end
end
