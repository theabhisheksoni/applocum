class HomeController < ApplicationController
  def index
    if current_user.patient?
      @doctors = User.doctor
    elsif current_user.doctor?
      @appointments = Appointment.unaccepted
    end
  end
end
