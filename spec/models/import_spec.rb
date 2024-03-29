require 'rails_helper'
require 'csv'

RSpec.describe Import, type: :model do
  it { is_expected.to define_enum_for(:status).with_values([
    :on_hold,
    :processing,
    :failed,
    :finished
  ])}

  it { is_expected.to validate_presence_of(:csv_content) }
end
