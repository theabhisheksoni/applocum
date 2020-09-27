# Preview all emails at http://localhost:3000/rails/mailers/appointment_mailer
class AppointmentMailerPreview < ActionMailer::Preview
  def reminder_email
    AppointmentMailer.with(user: User.first, appointment: Appointment.first).reminder_email
  end
end
