module UsersHelper
  def subscription_cancelled
    unless current_user.stripe_customer_token.nil?
      @customer = Stripe::Customer.retrieve(current_user.stripe_customer_token)
      @subscription = @customer.subscriptions.data[0]
      @subscription.cancel_at_period_end
    end
  end
  def job_title_icon(title)
    case title
    when "Developer"
      "<i class='fa fa-code'></i>"
    when "Entrepreneur"
      "<i class='fa fa-lightbulb-o'></i>"
    when "Investor"
      "<i class='fa fa-money'></i>"
    else 
      "<i class='fa fa-question'></i>"
    end
  end
end