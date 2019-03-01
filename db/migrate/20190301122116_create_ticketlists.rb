class CreateTicketlists < ActiveRecord::Migration[5.2]
  def change
    create_table :ticketlists do |t|
      t.string :ticket
      t.integer :premium

      t.timestamps
    end
  end
end
