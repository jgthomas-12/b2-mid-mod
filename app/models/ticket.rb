class Ticket < ApplicationRecord
  has_many :employee_tickets
  has_many :employees, through: :employee_tickets


  # def self.ticket_order
  #   order(age: :desc)
  # end
end

