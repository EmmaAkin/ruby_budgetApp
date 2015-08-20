class ExpensesCategory < ActiveRecord::Migration

  def change
    create_table :expenses_category do |t|
      t.string :title, null: false
      t.string :period, default: "Monthly"
      t.integer :amount,  default: 0

      t.timestamps(null: false)
    end
  end



  def down
    drop_table :expenses_category
  end


end
