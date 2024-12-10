class FormsController < ApplicationController
  def index
    @forms = Form.all
  end

  def show
    @form = Form.find(params[:id])
  end

  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)

    if @form.save
      if @form.processed_in_job?
        OpenaiProcessingJob.perform_later(@form.id)
        flash[:notice] = "Your request is being processed. We'll notify you when it's ready"
      else
        OpenaiProcessingJob.perform_now(@form.id)
      end

      redirect_to @form
    else
      render :new
    end
  end

  private

  def form_params
    params.require(:form).permit(:name, :description, :processed_in_job, :email)
  end
end
