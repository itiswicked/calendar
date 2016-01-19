FactoryGirl.define do
  factory :user do
    first_name 'Smitty'
    last_name 'Werbenjagermanjensen'
    email 'example@example.com'
    password 'password'
    password_confirmation 'password'
  end
end
