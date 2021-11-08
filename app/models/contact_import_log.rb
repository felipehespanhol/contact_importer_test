class ContactImportLog < ApplicationRecord
  validates :failure, presence: true
end
