FactoryBot.define do
  factory :comment do
    body { "MyString" }
    user
    movie
  end
end
