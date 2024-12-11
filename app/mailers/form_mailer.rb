class FormMailer < ApplicationMailer
  default from: ENV["MAILER_USER"]

  def form_submission(form)
    @form = form
    mail(to: @form.email, subject: "Your form has been submitted")
  end

  def response_status_changed(response)
    @response = response
    @form = @response.form
    mail(to: @form.email, subject: "Response status changed to #{@response.status}")
  end

  def notify_completed_form(form)
    @form = form

    # Ensure you define a from address here
    mail(
      to: @form.email,
      subject: "Your form processing is complete",
      from: ENV["MAILER_USERNAME"]
    )
  end
end
