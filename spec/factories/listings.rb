FactoryBot.define do
  factory :listing do
    category {'Car park'}
    lead { 'vacant' }
    scene { 'indoor' }
    height { 4 }
    description { 'Gated park with night lamp' }
    price { 200 }

  end
end
