FactoryGirl.define do
  factory :review do
    body { Faker::Hipster.paragraph }
    user nil
    idea nil
  end
end
