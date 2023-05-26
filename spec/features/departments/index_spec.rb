require "rails_helper"

RSpec.describe '/departments' do
  describe 'as a visitor' do
    describe 'when I visit the department index page' do
      # As a user,
      # When I visit the Department index page,
      # I see each department's name and floor
      # And underneath each department, I can see
      # the names of all of its employees

      it 'it displays a departments name and floor' do
        dep_1 = Department.create!(name: "Sales", floor: "2")
        dep_2 = Department.create!(name: "Development", floor: "1")

        visit "/departments"
        expect(page).to have_content("Department Name: #{dep_1.name}")
        expect(page).to have_content("Floor: #{dep_1.floor}")

        expect(page).to have_content("Department Name: #{dep_2.name}")
        expect(page).to have_content("Floor: #{dep_2.floor}")
      end

      it 'displays the employee names under each department' do
        dep_1 = Department.create!(name: "Sales", floor: "2")
        dep_2 = Department.create!(name: "Development", floor: "1")

        emp_1 = dep_1.employees.create!(name: "Joey", level: 9)
        emp_2 = dep_1.employees.create!(name: "Ricky", level: 17)
        emp_3 = dep_2.employees.create!(name: "Lars", level: 4)

        visit "/departments"
        within "#dept-#{dep_1.id}" do
        expect(page).to have_content(emp_1.name)
        expect(page).to have_content(emp_2.name)
        expect(page).to_not have_content(emp_3.name)
        end
      end
    end
  end
end