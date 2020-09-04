FactoryBot.define do
  factory :listing do
    category {'Car park'}
    lead { 'vacant' }
    scene { 'indoor' }
    description { 'Gated park with night lamp' }
    price { 200 }
    address {'Lövåsvägen 21 16733 Bromma'}
    association :landlord, factory: :user
    trait :with_images do
      after :create do |listing|
        file_path = Rails.root.join('spec', 'support', 'assets', 'test.jpg')
        file = fixture_file_upload(file_path, 'image/jpg')
        listing.images.attach(file)
      end
    end
  end
end
