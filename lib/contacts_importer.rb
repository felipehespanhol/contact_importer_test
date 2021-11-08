class ContactsImporter
  attr_reader :import, :csv_content, :column_options

  def initialize(import)
    @import = import
    @csv_content = import.csv_content
    @column_options = import.column_options.with_indifferent_access
  end

  def import!
    import.processing!

    ContactParser.parse(csv_content, column_options).map do |contact_data|
      Contact.create!(contact_data)
    end

    import.finished!
  end
end
