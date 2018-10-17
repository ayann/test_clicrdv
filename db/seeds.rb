# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

calendar    = Calendar.create(name: 'Mr Dupont', intervals: 10)
massage     = Intervention.create(calendar: calendar, name: 'Massage', duration: 30)
hair_remove = Intervention.create(calendar: calendar, name: 'Hair remove', duration: 40)

Opening.create(
  calendar: calendar,
  start_at: '2018-11-01 08:00:00',
  end_at: '2018-11-01 12:00:00'
)

Appointment.create(
  calendar: calendar,
  intervention: massage,
  start_at: '2018-11-01 09:00:00',
  customer_name: 'Toto'
)

Appointment.create(
  calendar: calendar,
  intervention: hair_remove,
  start_at: '2018-11-01 10:00:00',
  customer_name: 'Max'
)
