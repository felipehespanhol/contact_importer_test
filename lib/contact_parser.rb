require 'csv'

class ContactParser
  DEFAULT_COLUMN_MAPPING = {
    name: 'Name',
    email: 'Email',
    address: 'Address',
    phone: 'Phone',
    credit_card: 'Credit card',
    date_of_birth: 'Date of birth',
  }.freeze

  DELIMITER = ';'

  attr_reader :csv_content, :column_mapping

  def initialize(csv_content, column_mapping=nil)
    @csv_content = csv_content
    @column_mapping = column_mapping || DEFAULT_COLUMN_MAPPING
  end

  def parse
    parsed_csv.map do |row|
      {
        name: row[column_mapping[:name]],
        email: row[column_mapping[:email]],
        address: row[column_mapping[:address]],
        phone: row[column_mapping[:phone]],
        credit_card: row[column_mapping[:credit_card]],
        date_of_birth: row[column_mapping[:date_of_birth]],
      }
    end
  end

  def self.parse(csv_content, column_mapping=nil)
    self.new(csv_content, column_mapping).parse
  end

  private

  def parsed_csv
    CSV.parse(csv_content, headers: true, col_sep: DELIMITER)
  end
end
