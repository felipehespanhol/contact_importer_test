class ContactsImporter
  class FinishedOrFailedImportError < StandardError; end
  class ImportAlreadyProcessingError < StandardError; end

  attr_reader :import, :csv_content, :column_options, :contacts_created, :contacts_failed

  def initialize(import)
    @import = import
    @csv_content = import.csv_content
    @column_options = import.column_options.with_indifferent_access
    @contacts_created = []
    @contacts_failed = []
  end

  def import!
    raise FinishedOrFailedImportError if ['finished', 'failed'].include?(import.status)
    raise ImportAlreadyProcessingError if import.processing?

    import.processing!

    create_contacts

    if @contacts_created.empty?
      import.failed!
    else
      import.finished!
    end
  end

  private

  def create_contacts
    parsed_csv.each do |contact_data|
      new_contact = Contact.new(contact_data)

      if new_contact.save
        @contacts_created << new_contact
      else
        @contacts_failed << log_failing_row(new_contact, contact_data)
      end
    end
  end

  def parsed_csv
    ContactParser.parse(csv_content, column_options)
  end

  def log_failing_row(new_contact, contact_data)
    failure_message = new_contact.errors.full_messages.join(', ')

    ContactImportLog.create(row: contact_data.to_json, failure: failure_message)
  end
end
