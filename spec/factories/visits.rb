FactoryGirl.define do
  factory :visit do
    store_id 1
    customer_id 1
    near_location false
    check_in_code "MyString"
  end
end
