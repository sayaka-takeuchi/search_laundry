class AddCommentsToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :gender, :integer, null: false
    add_column :comments, :age_id, :integer, null: false
    add_column :comments, :rate_id, :integer, null: false
  end
end