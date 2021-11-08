require 'contact_parser'

class Import < ApplicationRecord
  attr_accessor :file

  enum status: {
    on_hold: 0,
    processing: 1,
    failed: 2,
    finished: 3
  }

  validates :csv_content, presence: true

  after_initialize :populate_csv_content_with_file, if: -> { self.file.present? }

  private

  def populate_csv_content_with_file
    self.csv_content = file.read
  end
end
