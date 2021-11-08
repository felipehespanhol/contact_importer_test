require 'rails_helper'
require 'contacts_importer'

RSpec.describe ContactsImporter do
  describe '#import!' do
    let(:parsed_csv) { CSV.read('fixtures/contacts_sample.csv', headers: true, col_sep: ';') }
    let(:file) { File.open('fixtures/contacts_sample.csv') }
    let(:column_options) do
      {
        name: 'Name',
        email: 'Email',
        address: 'Address',
        phone: 'Phone',
        credit_card: 'Credit card',
        date_of_birth: 'Date of birth',
      }
    end
    let(:import){ Import.create(file: file, column_options: column_options) }

    subject { described_class.new(import).import! }

    it 'creates contacts according to CSV contents' do
      expect { subject }.to change { Contact.count }.by 3

      Contact.find_each.with_index do |contact, index|
        expect(contact.name).to eq(parsed_csv[index][column_options[:name]])
        expect(contact.email).to eq(parsed_csv[index][column_options[:email]])
        expect(contact.address).to eq(parsed_csv[index][column_options[:address]])
        expect(contact.phone).to eq(parsed_csv[index][column_options[:phone]])
        expect(contact.credit_card).to eq(parsed_csv[index][column_options[:credit_card]])
        expect(contact.date_of_birth.strftime('%F')).to eq(parsed_csv[index][column_options[:date_of_birth]])
      end
    end
  end
end
