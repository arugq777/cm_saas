class Users::RegistrationsController < Devise::RegistrationsController
  before_action :only_current_user, only: :update
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_payment
        else
          resource.save
        end
      end
    end
  end

  def update

    super do |resource|
      if params[:update_billing]
        #change card for payment or upgrading from basic to pro
        resource.stripe_card_token = params[:user][:stripe_card_token]
        resource.save_billing_changes 
      elsif params[:upgrade_plan]
        resource.stripe_card_token = params[:user][:stripe_card_token]
        resource.plan_id = 2
        resource.save_with_payment
      elsif params[:cancel_plan]
        resource.cancel_billing
      else
        resource.save
      end

    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :plan_id, :stripe_card_token, :description)
    end

    def only_current_user
      @user = User.find(current_user.id)
    end
end
