FactoryBot.define do
  factory :bidding do
    bid { 1.5 }
    association :listing, factory: :listing
  end
end
