FactoryGirl.define do
  factory :idea do
    sequence(:title) {|n| Faker::Commerce.product_name + "#{n}"}
    description Faker::Hacker.say_something_smart
  end
end
