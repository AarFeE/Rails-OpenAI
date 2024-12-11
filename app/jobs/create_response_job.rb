class CreateResponseJob < ApplicationJob
    queue_as :default

    def perform(form_id)
        form = Form.find(form_id)

        ai_response = OpenaiProcessingJob.perform(form_id)

        response = form.create_response(ai_response: ai_response, status: "completed")

        FormMailer.response_ready_email(response).deliver_now
    end
end
