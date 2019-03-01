class Quotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      
      t.date  :close_time
      t.string :ticket
      
      t.timestamps
    end
  end
end
