require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'db table' do
    it{is_expected.to have_db_column :email}
    it{is_expected.to have_db_column :encrypted_password}
  end
  
  describe 'validations' do
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_presence_of :password}
  end

  describe 'Factory' do
    it 'should have valid factory' do
      expect(FactoryBot.create(:user)).to be_valid
    end
  end
end