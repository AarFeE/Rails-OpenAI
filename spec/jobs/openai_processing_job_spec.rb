require 'rails_helper'

RSpec.describe OpenaiProcessingJob, type: :job do
  include ActiveJob::TestHelper

  let(:form) {
    Form.create(
      name: "Test Form",
      description: "Test Description",
      processed_in_job: true
    )
  }

  before do
    # Mock OpenAI API call
    allow(OpenAI::Client).to receive_message_chain(:new, :chat, :dig)
      .and_return("Mocked OpenAI Response")
  end

  it "enqueues the job" do
    expect {
      OpenAiProcessingJob.perform_later(form.id)
    }.to have_enqueued_job(OpenAiProcessingJob)
  end

  it "creates a response" do
    expect {
      OpenAiProcessingJob.perform_now(form.id)
    }.to change(Response, :count).by(1)
  end

  it "sets response status to completed" do
    OpenAiProcessingJob.perform_now(form.id)
    response = form.response
    expect(response.status).to eq 'completed'
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
