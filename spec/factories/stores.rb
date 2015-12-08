FactoryGirl.define do
  factory :store do
    name "DBC Burgers"
    address "351 W Hubbard St, Chicago, IL 60654, USA"
    latitude 41.8897170
    longitude -87.6376110
    daily_code "DBCRocks!"
    owner_id 1
  end
end
