class Contact < ApplicationRecord
  validates :name,
            :email,
            :date_of_birth,
            :phone,
            :address,
            :credit_card,
            :franchise,
            presence: true
end
