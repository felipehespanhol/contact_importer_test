require 'rails_helper'
require 'contacts_importer'

RSpec.describe ContactsImporter do
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

  describe '#import!' do
    context 'when valid CSV file is provided' do
      let(:parsed_csv) { CSV.read('fixtures/contacts_sample.csv', headers: true, col_sep: ';') }
      let(:file) { File.open('fixtures/contacts_sample.csv') }
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

      it 'sets the import status to finished' do
        expect { subject }.to change { import.reload.status }.from('on_hold').to('finished')
      end
    end

    context 'when CSV is malformatted' do
      let(:invalid_content) { 'açsdkfjçalskdjfçaksjdçflkajsdf' }
      let(:import){ Import.create(csv_content: invalid_content, column_options: column_options) }

      subject { described_class.new(import).import! }

      it 'does not create' do
        expect { subject }.not_to change { Contact.count }
      end

      it 'sets the import status to failed' do
        expect { subject }.to change { import.reload.status }.from('on_hold').to('failed')
      end
    end

    context 'when a row does not create a contact' do
      let(:parsed_csv) { CSV.read('fixtures/contacts_sample_invalid_row.csv', headers: true, col_sep: ';') }
      let(:file) { File.open('fixtures/contacts_sample_invalid_row.csv') }
      let(:import){ Import.create(file: file, column_options: column_options) }

      subject { described_class.new(import).import! }

      it 'creates contacts with valid rows' do
        expect { subject }.to change { Contact.count }.by 2
      end

      it 'sets the import status to finished' do
        expect { subject }.to change { import.reload.status }.from('on_hold').to('finished')
      end

      it 'creates a contact import log with the failing row' do
        expect { subject }.to change { ContactImportLog.count }.by 1

        contact_import_log = ContactImportLog.last

        expect(contact_import_log.row).to eq('{"name":"Norene\u0026Kuhn","email":"norene@email.com","address":"43543 Parker Cliffs, West Jerestad, KS 43619","phone":"(+57) 998-888-88-880000","credit_card":"371449635398431","date_of_birth":"1990-05-07"}')
        expect(contact_import_log.failure).to eq('Name is invalid, Phone is invalid')
      end
    end
  end
end
