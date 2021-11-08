require 'credit_card_validations/string'

class Contact < ApplicationRecord
  validates :name,
            :email,
            :date_of_birth,
            :phone,
            :address,
            :credit_card,
            :franchise,
            presence: true

  validates :name, format: { with: /\A[A-Za-z0-9\-\s]+\z/ }
  validates :phone, format: { with: /\A\(\+[0-9]{2}\)\s([0-9]{3}\-[0-9]{3}\-[0-9]{2}\-[0-9]{2}|[0-9]{3}\s[0-9]{3}\s[0-9]{2}\s[0-9]{2})\z/ }
  validates :email, email: true

  after_initialize :set_franchise
  before_validation :set_franchise

  private

  def set_franchise
    return if credit_card.blank?

    self.franchise = credit_card.credit_card_brand_name
  end
end
