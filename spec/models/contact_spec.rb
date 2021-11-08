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
end
