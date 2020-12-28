require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User's validity" do
    context "When user provides all the correct and required info" do
      let!(:user) { build(:user) }
      it 'Valid user' do
        expect(user).to be_valid
      end

      it 'Valid user when username is unique' do
        user = create(:user)
        user1 = build(:user)
        user1.username = "simpson"
        user1.email = "simpson@gmail.com"
        expect(user1).to be_valid
      end
    end
    
    context "When user does not provide required info" do
      let!(:user) { build(:user) }
      it 'Invalid user when no email is given' do
        user.email = ""
        expect(user).not_to be_valid
      end

      it 'Invalid user when no first_name is given' do
        user.first_name = ""
        expect(user).not_to be_valid
      end

      it 'Invalid user when no first_name is given' do
        user.last_name = ""
        expect(user).not_to be_valid
      end

      it 'Invalid user when no first_name is given' do
        user.username = ""
        expect(user).not_to be_valid
      end

      it 'Invalid user when username is not unique' do
        user = create(:user)
        user1 = build(:user)
        expect(user1).not_to be_valid
      end
      
      it 'Invalid user when email is not unique' do
        user = create(:user)
        user1 = build(:user)
        user1.email = user.email
        expect(user1).not_to be_valid
      end
      
      it 'Invalid user when username does not signup with a valid plan' do
        user = build(:user)
        user.plan_id=nil
        expect(user).not_to be_valid
      end
    end
  end
end
