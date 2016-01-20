date_times = [8, 11, 13, 15, 17, 18].map do |n|
  t = Time.new(2016, 1, n)
  { start_time: t.to_s, end_time: (t + (60 * 60 * 11)).to_s }
end

FactoryGirl.define do
  factory :user do
    first_name 'Smitty'
    last_name 'Werbenjagermanjensen'
    email 'example@example.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :january_event, class: Event do
    sequence(:title) { |n| "Event#{n}" }
    sequence(:description) { |n| "Description#{n}" }
    sequence(:start_time) { |n| date_times[n][:start_time] }
    sequence(:end_time) { |n| date_times[n][:end_time] }
  end
end
