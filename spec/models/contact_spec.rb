require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:date_of_birth) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:credit_card) }
  it { is_expected.to validate_presence_of(:franchise) }

  it 'sets franchise with credit card number' do
    contact = create(:contact, :mastercard, franchise: nil)

    expect(contact.franchise).to eq('MasterCard')
  end

  it 'does not allow names with special characters' do
    contact = build(:contact, name: '&&**(!!)')
    contact.save
    expect(contact.errors.messages).to include(:name)
  end

  it 'only allows phone numbers of a giver format' do
    contact_with_valid_phone_number1 = build(:contact, phone: '(+00) 000 000 00 00')
    contact_with_valid_phone_number2 = build(:contact, phone: '(+00) 000-000-00-00')
    contact_with_invalid_phone_number1 = build(:contact, phone: '+00 000 000 00 00 00 00')
    contact_with_invalid_phone_number2 = build(:contact, phone: '(+00) 000-000-00-00-00')
    expect(contact_with_valid_phone_number1).to be_valid
    expect(contact_with_valid_phone_number2).to be_valid
    expect(contact_with_invalid_phone_number1).not_to be_valid
    expect(contact_with_invalid_phone_number2).not_to be_valid
  end
end
