require 'rails_helper'

require 'contact_parser'

RSpec.describe ContactParser do
  let(:file_contents) { File.read('fixtures/contacts_sample.csv') }
  let(:parsed_csv) { CSV.parse(file_contents, headers: true, col_sep: ';') }

  describe '.parse' do
    context 'with default column names' do
      subject { described_class.parse(file_contents) }

      it 'returns an array of hashes with contacts data' do
        expect(subject.size).to eq(3)

        subject.each_with_index do |contact_data, index|
          expect(contact_data[:name]).to eq(parsed_csv[index]['Name'])
          expect(contact_data[:email]).to eq(parsed_csv[index]['Email'])
          expect(contact_data[:address]).to eq(parsed_csv[index]['Address'])
          expect(contact_data[:phone]).to eq(parsed_csv[index]['Phone'])
          expect(contact_data[:credit_card]).to eq(parsed_csv[index]['Credit card'])
          expect(contact_data[:date_of_birth]).to eq(parsed_csv[index]['Date of birth'])
        end
      end
    end

    context 'with customized column names' do
      let(:file_contents) { File.read('fixtures/contacts_sample_customized_columns.csv') }
      let(:column_config) do
        {
          name: 'Name of the contact',
          email: 'Email address',
          address: 'Contact Address',
          phone: 'Phone Number',
          credit_card: 'Credit card number',
          date_of_birth: 'Birthday',
        }
      end

      subject { described_class.parse(file_contents, column_config) }

      it 'returns an array of hashes with contacts data' do
        expect(subject.size).to eq(3)

        subject.each_with_index do |contact_data, index|
          expect(contact_data[:name]).to eq(parsed_csv[index]['Name of the contact'])
          expect(contact_data[:email]).to eq(parsed_csv[index]['Email address'])
          expect(contact_data[:address]).to eq(parsed_csv[index]['Contact Address'])
          expect(contact_data[:phone]).to eq(parsed_csv[index]['Phone Number'])
          expect(contact_data[:credit_card]).to eq(parsed_csv[index]['Credit card number'])
          expect(contact_data[:date_of_birth]).to eq(parsed_csv[index]['Birthday'])
        end
      end
    end
  end
end
