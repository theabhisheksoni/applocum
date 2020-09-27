namespace :operations do
  desc 'Create, update, delete addressee'
  task send_reminders: :environment do
    Appointment.all.each do |appointment|
      next if appointment.appointment_date > (DateTime.now + 1.hour)

      AppointmentMailer.with(user: appointment.doctor, appointment: appointment).reminder_email.deliver_later
      AppointmentMailer.with(user: appointment.patient, appointment: appointment).reminder_email.deliver_later
    end
  end
end
