require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User's validity" do
    context "When user provides all the required info" do
      let!(:user) { build(:user) }
      it 'Valid user' do
        expect(user).to be_valid
      end
    end
    context "When user does not provide required info" do
      let!(:user) { build(:user) }
      it 'Valid user' do
        user.email = ""
        expect(user).not_to be_valid
      end
    end
  end
end
