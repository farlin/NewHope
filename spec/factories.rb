FactoryBot.define do
  factory :person do
    first_name { "MyString" }
    last_name { "MyString" }
    gender { 1 }
    weapon { "MyString" }
    vehicle { "MyString" }
  end

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