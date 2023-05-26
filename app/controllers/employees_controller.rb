class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
    @ticket = @employee.tickets
  end

end