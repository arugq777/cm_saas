class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :profile
  belongs_to :plan


  attr_accessor :stripe_card_token

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end

  # change card used for payment, or upgrade from basic
  def save_billing_changes
    if valid?
      customer = Stripe::Customer.retrieve(self.stripe_customer_token)
      customer.description = self.email
      customer.source = self.stripe_card_token
      customer.update_subscription({plan: self.plan_id})
      customer.save
      save!
    end
  end

  def cancel_billing
    if valid?
      customer = Stripe::Customer.retrieve(self.stripe_customer_token)

      # rather than retrieving the subscription in a seperate var, we're just
      # cancelling the first one directly, as there shouldn't be more.
      customer.subscriptions.data[0].delete(at_period_end: true)
      save!
    end
  end
end
