class FormsController < ApplicationController
  def index
    forms = Form.all

    render :index, locals: { forms: forms }
  end

  def new
    form = Form.new

    render :new, locals: { form: form }
  end

  def create
    form = Form.new(form_params)

    if form.save
      redirect_to forms_path
    else
      render :new, locals: { form: form }
    end
  end

  def edit
    form = Form.find(params[:id])

    render :edit, locals: { form: form }
  end

  def update
    form = Form.find(params[:id])

    if form.update(form_params)
      redirect_to forms_path
    else
      render :edit, locals: { form: form }
    end

  # rescue ActiveRecord::StaleObjectError
    # form was updated by somebody else before
  end

  private
  def form_params
    params.require(:form).permit(:name, :content, :lock_version)
  end
end
