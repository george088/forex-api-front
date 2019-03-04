class Ticketlist < ApplicationRecord
  def self.tickets user_role = 0
    Ticketlist.where("premium <= ?", user_role).pluck(:ticket)
  end
end
