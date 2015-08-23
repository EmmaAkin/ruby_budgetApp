class Expenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :title, null: false
      t.string :period, null:false, default: "Monthly"
      t.integer :amount,  null:false, default: 0
      #t.string :expenses_category, null: false, default: "Others"


      t.timestamps(null: false)
    end
  end



  def down
    drop_table :expenses
  end
end
