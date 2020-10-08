class LaundriesController < ApplicationController
  before_action :search_laundry, only: [:index, :search]

  def index
    @laundries = Laundry.order('opening_date DESC')
  end

  def new
    @laundry = Laundry.new
  end

  def create
    @laundry = Laundry.new(laundry_params)
    if @laundry.save
      redirect_to root_path
    else
      render :new
    end
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

  def laundry_params
    params.require(:laundry).permit(:name, :address, :opening_date, :open_time, :close_time, :shoe_washing, :futon_washing, :dryer, :washing_machine, :image)
  end
end
