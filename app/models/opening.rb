# == Schema Information
#
# Table name: openings
#
#  id          :integer          not null, primary key
#  end_at      :datetime
#  start_at    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  calendar_id :integer
#

class Opening < ActiveRecord::Base
  # Association
  belongs_to :calendar

  # Presence validations
  with_options presence: true do
    validates :calendar
    validates :start_at
    validates :end_at
  end

  # Timeliness validations
  validates_datetime :start_at, on: :create, on_or_after: :now, ignore_usec: true
  validates_datetime :end_at, after: :start_at

  # Custom validations
  validate :same_date
  validate :overlapping

  # Return overlapping opening
  scope :overlapping, ->(start_at, end_at) do
    args = { start_at: start_at, end_at: end_at }
    where('start_at < :end_at AND end_at > :start_at', **args)
  end

  # Return actives opening, those whose end_at have not expired
  scope :actives, -> { where('end_at > ?', Time.current) }

  private

  # Custom validation for model, to check overlapping time range
  def overlapping
    return unless calendar && sibling_overlappings?
    errors.add(:base, :overlapping)
  end

  # Check overlappings siblings
  def sibling_overlappings?
    overlappings = calendar.openings.overlapping(start_at, end_at)
    (persisted? ? overlappings.where.not(id: self) : overlappings).any?
  end

  # Custom validation for model, for a day boundaries
  def same_date
    return unless start_at? && end_at?
    return unless start_at.to_date != end_at.to_date

    errors.add(:start_at, :same_date)
    errors.add(:end_at, :same_date)
  end
end
