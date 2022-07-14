FactoryBot.define do
  factory :location do
    address { "MyString" }
  end

  factory :affiliation do
    name { "MyString" }
  end



  factory(:user) do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end