require 'rails_helper'

RSpec.describe Listing, type: :model do

  it 'should have a valid Factory' do
    expect(create(:listing)).to be_valid
  end

  describe 'Database table' do
    it { is_expected.to have_db_column :category }
    it { is_expected.to have_db_column :lead }
    it { is_expected.to have_db_column :scene }
    it { is_expected.to have_db_column :address }
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column :price }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :category}
    it { is_expected.to validate_presence_of :lead }
    it { is_expected.to validate_presence_of :scene }
    it { is_expected.to validate_presence_of :address}
    it { is_expected.to validate_presence_of :description}
    it { is_expected.to validate_presence_of :price }  
  end
end