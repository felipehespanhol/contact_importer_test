require 'rails_helper'

RSpec.describe ContactImportLog, type: :model do
  it { is_expected.to validate_presence_of(:failure) }
end
