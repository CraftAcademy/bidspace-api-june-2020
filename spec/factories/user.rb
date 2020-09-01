FactoryBot.define do
  factory :user do
    email { "user#{rand(1...9999)}@mail.com" }
    password { "MyString" }
  end
end