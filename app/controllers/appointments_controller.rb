class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[destroy accept reject]

  def index
    @appointments = if current_user.patient?
                      current_user.patient_appointments
                    elsif current_user.doctor?
                      current_user.doctor_appointments
                    end
  end

  def new
    # create a new appointment for patient
    @appointment = current_user.patient_appointments.new
  end

  def create
    @appointment = current_user.patient_appointments.new(appointment_params)
    if @appointment.save
      redirect_to appointments_path, notice: 'Appointment created successfully'
    else
      render :new
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: 'Appointment Canceled (destroyed) successfully'
  end

  def accept
    @appointment.update(doctor_id: current_user.id)
    redirect_to appointments_path, notice: 'Appointment accepted successfully'
  end

  def reject
    @appointment.update(doctor_id: nil)
    redirect_to appointments_path, notice: 'Appointment rejected successfully'
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :doctor_id, :patient_id)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
