class CreateLaundries < ActiveRecord::Migration[6.0]
  def change
    create_table :laundries do |t|
      t.string :name,             null: false
      t.string :address,          null: false
      t.date :opening_date,       null: false
      t.time :open_time,          null: false
      t.time :close_time,         null: false
      t.boolean :shoe_washing,    null: false, default: false
      t.boolean :futon_washing,   null: false, default: false
      t.boolean :dryer,           null: false, default: true
      t.boolean :washing_machine, null: false, default: false
      t.timestamps
    end
  end
end
