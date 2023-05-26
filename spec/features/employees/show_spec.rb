require "rails_helper"

RSpec.describe '/employees/:id' do
  describe 'as a visitor' do
    describe 'when i visit the employee show page' do
      it 'displays the employees name and department' do
        dep_1 = Department.create!(name: "Sales", floor: "2")
        dep_2 = Department.create!(name: "Development", floor: "1")

        emp_1 = dep_1.employees.create!(name: "Joey", level: 9)
        emp_2 = dep_1.employees.create!(name: "Ricky", level: 17)
        emp_3 = dep_2.employees.create!(name: "Lars", level: 4)

        visit "/employees/#{emp_1.id}"

        expect(page).to have_content("Employee Name: #{emp_1.name}")
        expect(page).to have_content("Department Name: #{dep_1.name}")
        expect(page).to_not have_content("Employee Name: #{emp_2.name}")
        expect(page).to_not have_content("Department Name: #{dep_2.name}")

        visit "/employees/#{emp_3.id}"

        expect(page).to have_content("Employee Name: #{emp_3.name}")
        expect(page).to have_content("Department Name: #{dep_2.name}")
        expect(page).to_not have_content("Employee Name: #{emp_2.name}")
        expect(page).to_not have_content("Department Name: #{dep_1.name}")
      end

      it 'lists all of the employees tickets from oldest to newest' do
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

        visit "/employees/#{emp_1.id}"

        expect(ticket_2.subject).to appear_before(ticket_1.subject)

        visit "/employees/#{emp_2.id}"

        expect(ticket_2.subject).to appear_before(ticket_3.subject)

      end

      it "displays the oldest ticket assigned to each employee" do
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

        visit "/employees/#{emp_1.id}"
        within "#old-tick-#{emp_1.id}" do
        expect(page).to have_content("Oldest Ticket: #{ticket_2.subject}")
        expect(page).to_not have_content("Oldest Ticket: #{ticket_1.subject}")
        end

        visit "/employees/#{emp_2.id}"
        within "#old-tick-#{emp_2.id}" do
        expect(page).to have_content("Oldest Ticket: #{ticket_2.subject}")
        expect(page).to_not have_content("Oldest Ticket: #{ticket_3.subject}")
        end

      end
    end
  end
end
