class AddEncryptionToContactsCreditCard < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :encrypted_credit_card, :string
    remove_column :contacts, :credit_card
  end
end
