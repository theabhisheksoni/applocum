class AppointmentMailer < ApplicationMailer
  def reminder_email
    @user = params[:user]
    @appointment = params[:appointment]
    mail(to: @user.email, subject: 'Appointment Reminder')
  end
end
