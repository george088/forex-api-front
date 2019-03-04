class Quote < ApplicationRecord
  def self.quotes tickets, type, from, to
      Quote.where(ticket: tickets, close_time: from..to).pluck(type)
  end
end
