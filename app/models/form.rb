class Form < ApplicationRecord
  has_one :response

  validates :name, presence: true
  validates :processed_in_job, inclusion: { in: [ true, false ] }
end
