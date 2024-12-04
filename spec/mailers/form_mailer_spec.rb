require 'rails_helper'

RSpec.describe FormMailer, type: :mailer do
  describe "response_ready" do
    let(:form) {
      Form.create(
        name: "Test Form",
        description: "Test Description",
        processed_in_job: true
      )
    }
    let(:mail) { FormMailer.response_ready(form) }

    it "renders the headers" do
      expect(mail.subject).to eq("Your Form Response is Ready")
      expect(mail.to).to eq([ "user@example.com" ])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include("Your form response is ready")
    end
  end
end
