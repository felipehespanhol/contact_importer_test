require 'rails_helper'

RSpec.describe ImporterWorker, type: :worker do
  describe '#perform' do
    let(:import) { create(:import) }
    let(:contacts_importer_instance) { spy }

    before do
      allow(ContactsImporter).to receive(:new).with(import).and_return(contacts_importer_instance)
    end

    subject { described_class.new.perform(import.id) }

    it 'imports contacts' do
      subject

      expect(contacts_importer_instance).to have_received(:import!)
    end
  end
end
