class AddTickets < ActiveRecord::Migration[5.2]
  def change
    Ticketlist.create ticket: 'EURUSD', premium: '0'
    Ticketlist.create ticket: 'USDCAD', premium: '0'
    Ticketlist.create ticket: 'USDJPY', premium: '1'
    Ticketlist.create ticket: 'GBPUSD', premium: '1'
  end
end
