require 'rails_helper'

RSpec.describe Listing, type: :model do

  it 'should have a valid Factory' do
    expect(create(:listing)).to be_valid
  end

  describe 'Database table' do
    it { is_expected.to have_db_column :category }
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column :scene }
    it { is_expected.to have_db_column :height }
    it { is_expected.to have_db_column :address }
    it { is_expected.to have_db_column :price }
  end
end
