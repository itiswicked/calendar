def dates
  ([8, 11, 13, 15, 17, 18] * 20).map do |n|
    t = Time.new(Time.now.year, Time.now.month, n)
    { start_time: t.to_s, end_time: (t + (60 * 60 * 11)).to_s }
  end
end

FactoryGirl.define do
  factory :user do
    first_name 'Smitty'
    last_name 'Werbenjagermanjensen'
    email 'example@example.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :event, class: Event do
    sequence(:title) { |n| "Event#{n}" }
    sequence(:description) { |n| "Description#{n}" }
    sequence(:start_time) { |n| dates[n][:start_time] }
    sequence(:end_time) { |n| dates[n][:end_time] }
  end

  factory :resource do
    event
    inventory_item
    quantity 4
  end

  factory :inventory_item do
    name "Source PAR WFL"
    category "Lighting"
  end
end
