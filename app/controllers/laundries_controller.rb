class LaundriesController < ApplicationController
  def index
    @laundries = Laundry.order('opening_date ASC')
  end
end
