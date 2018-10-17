##
# This class is a service used to get availables slots for an intervention of specified calendar

class TimeSlot
  attr_reader :openings, :intervals, :appointments, :duration

  ##
  # Class method. Direct shortcuts of instance methods
  class << self
    %i[availables all].each do |meth|
      define_method(meth) do |calendar, intervention|
        instance = new(calendar, intervention)
        instance.public_send(meth)
      end
    end
  end

  # Return all availables slots of specific intervention for this calendar
  #
  # @param intervention [Intervention] the intervention who search availabilities
  # @return [Array] the collection of availabilities
  def initialize(calendar, intervention)
    @openings     = calendar.openings
    @intervals    = calendar.intervals
    @appointments = calendar.appointments
    @duration     = intervention.duration
  end

  # Return all slots
  #
  # @return [Array] the collection of slots
  def all
    @_all ||= begin
      @openings
        .map { |opening| opening_slots(opening) }
        .flatten
        .reject { |slot| slot < Time.current }
    end
  end

  # Return availables slots
  #
  # @return [Array] the availables slots collection
  def availables
    return all if appointments.blank?

    @_availables ||= begin
      all.map do |slot_start_at|
        next unless available?(slot_start_at)
        slot_start_at
      end.flatten.compact.uniq
    end
  end

  private

  # Split opening time range in slots based on calendar intervals
  #
  # @param opening [Opening] the calendar opening object
  # @return [Array] the openings slots collection
  def opening_slots(opening)
    opening_start_at = opening.start_at
    opening_end_at   = opening.end_at

    slots = (1..number_of_slots(opening_start_at, opening_end_at)).map do |number|
      opening_start_at + ((number - 1) * @intervals).minutes
    end

    slots.reject { |slot| slot + @duration.minutes > opening_end_at }
  end

  # Number of slots can contains an opening
  #
  # @param start_at [Time] Opening start at
  # @param end_at [Time] Opening end at
  # @return [Integer] the openings slots number
  def number_of_slots(start_at, end_at)
    (end_at - start_at) / @intervals.minutes
  end

  # Check if a slot is available
  #
  # @param slot_start_at [Time] Slot start at
  # @return [Boolean] true if available false if not
  def available?(slot_start_at)
    appointments.map do |appointment|
      appointment_start_at = appointment.start_at
      appointment_end_at   = appointment.end_at
      slot_end_at          = slot_start_at + duration.minutes

      break if slot_end_at > appointment_start_at && slot_start_at < appointment_end_at

      slot_start_at
    end.present?
  end
end
