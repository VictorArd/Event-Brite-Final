class User < ApplicationRecord
  #
  has_many :attendances
  has_many :events, through: :attendances
  has_many :created_events, foreign_key: 'admin_id', class_name: "Event"
  
  #Validations
  validates :first_name, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { minimum: 3 }
  validates :description, length: { maximum: 1000, too_long: "%{count} caractères est le maximum autorisé" }

  #Mail
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end
