# frozen_string_literal: true

class ReceiverEmailsController < InheritedResource

  private

  def resource_params
    params.require(:receiver_email).permit(:name, :email)
  end

  def resource_class
    policy_scope(current_company&.receiver_emails)
  end
end
