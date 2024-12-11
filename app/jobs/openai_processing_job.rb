require "openai"

class OpenaiProcessingJob < ApplicationJob
  queue_as :default

  def perform(form_id)
    form = Form.find(form_id)

    begin
      client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
      response = client.chat(
        parameters: {
          model: "gpt-4",
          messages: [
            { role: "system", content: "You are a magic writer that will transform the received content to a beautiful poem, no matter how absurd it might be (also fill it with emojis)." },
            { role: "user", content: form.description }
          ]
        }
      )

      ai_response_text = response["choices"].first["message"]["content"]

      form.create_response!(
        ai_response: ai_response_text,
        status: :completed
      )

      # Notify the user via email
      FormMailer.notify_completed_form(form).deliver_now

    rescue StandardError => e
      Rails.logger.error("OpenAI API call failed: #{e.message}")
      form.create_response!(
        ai_response: e.message,
        status: :failed
      )
    end
  end
end
