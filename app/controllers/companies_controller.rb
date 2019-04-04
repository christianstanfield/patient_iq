class CompaniesController < ApplicationController
  before_action :load_resource, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @company.update permitted_attributes(@company)
      redirect_to @company, notice: 'Company updated successfully'
    else
      render :edit
    end
  end

  private

  def load_resource
    @company = Company.find_by id: params[:id]
    authorize @company
  end
end
