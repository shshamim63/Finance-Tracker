require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validates friendship' do
    let(:user) { create(:user)}
    let(:friend) { create(:user)}

    context "When all fields are given" do
      let(:friendship) { build(:friendship, status: 'accepted')}

      it "creates friendship if all fileds are filled" do
        expect(friendship).to be_valid
      end
    end
    context "when you are/have blocked a user" do
      it "does not create instance if the last status is blocked" do
        friendship_blocked = create(:friendship, user: user, friend: friend, status: 'blocked')
        friendship_rejected = build(:friendship, user: user, friend: friend, status: 'rejected')
        expect(friendship_rejected).not_to be_valid
      end
    end

    context "When fileds left empty" do
      let(:friendship) { build(:friendship, status: 'rejected')}
      
      it "creates friendship if user is empty" do
        friendship.user = nil
        expect(friendship).not_to be_valid
      end

      it "creates message if body is empty" do
        friendship.friend = nil
        expect(friendship).not_to be_valid
      end
    end
  end

  # describe "current_status?" do
  #   let(:user) { create(:user)}
  #   let(:friend) { create(:user)}

  #   context "When users are still friends." do
  #     let!(:friendship_rejected) { create(:friendship, user: user, friend: friend, status: 'rejected') }
  #     let!(:friendship_accepted) { create(:friendship, user: user, friend: friend, status: 'accepted') }

  #     it "is still a friend" do
  #       access = described_class.current_status?(user, friend)
  #       expect(access.status).to eq("accepted")
  #     end
  #   end

  #   context "When users are not friend anymore" do
  #     let!(:friendship_rejected) { create(:friendship, user: user, friend: friend, status: 'accepted') }
  #     let!(:friendship_accepted) { create(:friendship, user: friend, friend: user, status: 'rejected') }
      
  #     it "is still a friend" do
  #       access = described_class.current_status?(user, friend)
  #       expect(access.status).to eq("rejected")
  #     end
  #   end
  # end
end
