require 'rails_helper'

RSpec.describe Listing, type: :model do

  it 'should have a valid Factory' do
    expect(create(:listing)).to be_valid
  end

  describe 'Database table' do
    it { is_expected.to have_db_column :category }
    it { is_expected.to have_db_column :lead }
    it { is_expected.to have_db_column :scene }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :category}
    it { is_expected.to validate_presence_of :lead }
    it { is_expected.to validate_presence_of :scene }
  end
end
