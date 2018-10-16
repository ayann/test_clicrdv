class TimeSlot
  attr_reader :openings, :intervals, :appointments, :duration

  class << self
    %i[availables all].each do |meth|
      define_method(meth) do |calendar, intervention|
        instance = new(calendar, intervention)
        instance.public_send(meth)
      end
    end
  end

  def initialize(calendar, intervention)
    @openings     = calendar.openings
    @intervals    = calendar.intervals
    @appointments = calendar.appointments
    @duration     = intervention.duration
  end

  def all
    @_all ||= begin
      @openings
        .map { |opening| opening_slots(opening) }
        .flatten
        .reject { |slot| slot < Time.current }
    end
  end

  def availables
    @_availables ||= begin
      all.map do |slot_start_at|
        next unless available?(slot_start_at)
        slot_start_at
      end.flatten.compact.uniq
    end
  end

  private

  def opening_slots(opening)
    opening_start_at = opening.start_at
    opening_end_at   = opening.end_at

    slots = (1..number_of_slots(opening_start_at, opening_end_at)).map do |number|
      opening_start_at + ((number - 1) * @intervals).minutes
    end

    slots.reject { |slot| slot + @duration.minutes > opening_end_at }
  end

  def number_of_slots(start_at, end_at)
    (end_at - start_at) / @intervals.minutes
  end

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
