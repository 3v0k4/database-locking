class WriteController < ApplicationController
  def fetch
    render plain: Unique.all.map(&:id)
  end

  def create
    unique = Unique.new(unique_params)
    unique.save!

    render plain: "saved"

  rescue ActiveRecord::RecordNotUnique
    render plain: "NOT saved"
  end

  private
  def unique_params
    params.require(:unique).permit(:name)
  end
end
