class LaundriesController < ApplicationController
  before_action :search_laundry, only: [:index, :search]

  def index
    @laundries = Laundry.order('opening_date ASC')
  end

  def search
    @results = @laundry.result
  end

  def show
    @laundry = Laundry.find(params[:id])
  end

  private

  def search_laundry
    @laundry = Laundry.ransack(params[:q])
  end
end
