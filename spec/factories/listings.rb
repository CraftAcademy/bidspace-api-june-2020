FactoryBot.define do
  factory :listing do
    category {'Car park'}
    lead { 'vacant' }
    scene { 'indoor' }
    description { 'Gated park with night lamp' }
    price { 200 }
    address {'Lövåsvägen 21 16733 Bromma'}
    association :landlord, factory: :user
  end
end
