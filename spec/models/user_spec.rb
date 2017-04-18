require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires an email' do
      u = User.new
      u.valid?
      expect(u.errors.messages).to have_key(:email)
    end

    it 'requires a unique email' do
      s = FactoryGirl.create(:user)
      u = User.new email: s.email
      u.valid?
      expect(u.errors.messages).to have_key(:email)
    end
  end

end
