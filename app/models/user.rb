class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :patient_appointments, class_name: 'Appointment', foreign_key: 'patient_id'
  has_many :doctors, through: :patient_appointments

  has_many :doctor_appointments, class_name: 'Appointment', foreign_key: 'doctor_id'
  has_many :patients, through: :doctor_appointments

  ROLES = { 'patient' => 'patient', 'doctor' => 'doctor', 'admin' => 'admin' }

  enum role: ROLES
  validates :role, presence: true
end
