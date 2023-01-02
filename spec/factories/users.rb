FactoryBot.define do
  factory :user do
    email { 'default@learnertodriver.co.za' }
    password { 'test1234' }
    first_name { 'John' }
    last_name { 'Doe' }
    mobile { '0123456789' }
    status { 'active' }
    confirmed_at { 1.day.ago }

    factory :admin do
      email { 'admin@learnertodriver.co.za' }
      first_name { 'Jack' }
      role { :admin }
    end
  end
end
