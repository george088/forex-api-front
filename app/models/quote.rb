class Quote < ApplicationRecord
  def self.quotes tickets, type, from, to
    Quote.where(ticket: tickets, close_time: from..to).pluck(type)
  end

  def self.avalable_dates ticket
    d = Quote.where(ticket: tickets).pluck(:close_time)
    [from: d.first, to: d.last]
  end
end
