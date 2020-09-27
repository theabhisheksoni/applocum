class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: 'User', optional: true
  belongs_to :patient, class_name: 'User'

  validate :appointment_timing, on: :create
  before_destroy :cancelable

  scope :unaccepted, -> { where(doctor_id: nil) }

  def appointment_timing
    return if appointment_date > 5.hour.since

    errors.add(:appointment_date, 'Appointment must be scheduled at least 5 hours before.')
  end

  def can_cancel?
    DateTime.now < (created_at + 1.hour)
  end

  def cancelable
    return if can_cancel?

    errors.add(:base, 'Appointment can not be canceled after 1 hour of scheduling.')
    throw(:abort)
  end
end
