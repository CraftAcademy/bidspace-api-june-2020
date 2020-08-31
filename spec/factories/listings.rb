FactoryBot.define do
  factory :listing do
    category {'Car park'}
    description {'vacant'}
    scene {'indoors'}
    height {4}
    address{'Stockholm'}
    price {200}
  end
end
