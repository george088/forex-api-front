class Quotes < ActiveRecord::Migration[5.2]
  def change
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      t.date  :close_time

      t.timestamps
  end
end
