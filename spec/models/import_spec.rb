require 'rails_helper'

RSpec.describe Import, type: :model do
  it { is_expected.to define_enum_for(:status).with_values([
    :on_hold,
    :processing,
    :failed,
    :finished
  ])}
end
