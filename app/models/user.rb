# frozen_string_literal: true

# user model using devise
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company, optional: true

  validates :first_name, :last_name, presence: true
  validates :phone_number,
            presence: { message: I18n.t('customer.mobile_no_validation') },
            numericality: true,
            length: { minimum: 10, maximum: 15 }, uniqueness: true

  private

  def email_required?
    false
  end
end
