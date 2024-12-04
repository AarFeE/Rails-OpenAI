class Response < ApplicationRecord
  belongs_to :form

  enum status: {
    pending: 'pending',
    completed: 'completed',
    failed: 'failed'
  }
end
