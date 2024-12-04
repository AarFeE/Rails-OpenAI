require "openai"

class OpenaiProcessingJob < ApplicationJob
  queue_as :default

  def perform(form_id)
    form = Form.find(form_id)

    begin
      client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            { role: "system", content: "You are an assistant that provides helpful information." },
            { role: "user", content: form.description }
          ]
        }
      )

      ai_response_text = response["choices"].first["message"]["content"]

      form.create_response!(
        ai_response: ai_response_text,
        status: :completed
      )
    rescue StandardError => e
      Rails.logger.error("OpenAI API call failed: #{e.message}")
      form.create_response!(
        ai_response: e.message,
        status: :failed
      )
    end
  end
end
