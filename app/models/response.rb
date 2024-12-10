# app/models/response.rb
class Response < ApplicationRecord
  belongs_to :form
  enum status: { pending: 'pending', completed: 'completed', failed: 'failed' }

  after_update :send_status_change_email, if: :saved_change_to_status?

  private

  def send_status_change_email
    FormMailer.response_status_changed(self).deliver_later
  end
end
