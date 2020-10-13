class AddLatitudeToLaundory < ActiveRecord::Migration[6.0]
  def change
    add_column :laundries, :latitude, :float
    add_column :laundries, :longitude, :float
  end
end
