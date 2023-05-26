require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "relationships" do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it { should have_many(:tickets).through(:employee_tickets) }
  end

  describe 'instance methods' do
    it '#ticket_order' do
    dep_1 = Department.create!(name: "Sales", floor: "2")
    dep_2 = Department.create!(name: "Development", floor: "1")

    emp_1 = dep_1.employees.create!(name: "Joey", level: 9)
    emp_2 = dep_1.employees.create!(name: "Ricky", level: 17)
    emp_3 = dep_2.employees.create!(name: "Lars", level: 4)

    ticket_1 = Ticket.create!(subject: "Printer's Broken", age: 5)
    ticket_2 = Ticket.create!(subject: "PC Load Letter", age: 12)
    ticket_3 = Ticket.create!(subject: "Just Complicated", age: 9)

    emp_tick_1 = EmployeeTicket.create!(employee_id: emp_1.id, ticket_id: ticket_1.id )
    emp_tick_2 = EmployeeTicket.create!(employee_id: emp_1.id, ticket_id: ticket_2.id )
    emp_tick_3 = EmployeeTicket.create!(employee_id: emp_2.id, ticket_id: ticket_3.id )
    emp_tick_4 = EmployeeTicket.create!(employee_id: emp_2.id, ticket_id: ticket_2.id )

    expect(emp_1.ticket_order).to eq([ticket_2, ticket_1])

    end
  end
end