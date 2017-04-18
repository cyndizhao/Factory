FactoryGirl.define do
  factory :idea do
    sequence(:title) {|t| "Cool idea title #{t}"}
    body "Description of the idea"
    user nil
  end
end
