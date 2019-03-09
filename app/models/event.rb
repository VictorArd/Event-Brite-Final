class Event < ApplicationRecord

  #
  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :admin, class_name: "User"
  has_one_attached :image

  #Validations
  validates :start_date, presence: true
  validate :start_date_cannot_be_in_the_past

  validates :duration, numericality: { greater_than: 0, only_integer: true }
  validate :duration_multiple

  validates :title, presence: true, length: 4..140

  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than_or_equal_to: 1000, only_integer: true }

  validates :location, presence: true


  private
  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "Ne peut pas être dans le passé")
    end
  end

  def duration_multiple
    unless duration%5 == 0
      errors.add(:duration, "Ce n'est pas un multiple de 5")
    end
  end

end
