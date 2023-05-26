class EmployeeTicketsController < ApplicationController
  def create
    emp_tick = EmployeeTicket.create!(employee_id: params[:id], ticket_id: params[:ticket_id])
    employee = Employee.find_by(id: emp_tick.employee_id)
    redirect_to "/employees/#{employee.id}"
  end
end