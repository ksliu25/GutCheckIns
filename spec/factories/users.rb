FactoryGirl.define do
  factory :user, aliases: [:owner, :customer] do
    username "Kenneth"
    password "password"
  end
end
