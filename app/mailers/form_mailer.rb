class FormMailer < ApplicationMailer
    def response_ready(form)
      @form = form
      mail(
        to: "user@example.com",
        subject: "Your Form Response is Ready"
      )
    end
end
