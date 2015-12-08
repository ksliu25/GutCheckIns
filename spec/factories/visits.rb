FactoryGirl.define do
  factory :valid_visit do
    store
    customer
    near_location true
    check_in_code "DBCRocks!"
  end
end
