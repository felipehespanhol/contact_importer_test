class Import < ApplicationRecord
  enum status: {
    on_hold: 0,
    processing: 1,
    failed: 2,
    finished: 3
  }
end
