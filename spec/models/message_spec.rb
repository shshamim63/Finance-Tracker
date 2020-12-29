require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validates message' do
    context "When all fields are given" do
      let(:message) { build(:message)}
      it "creates message if all fileds are filled" do
        expect(message).to be_valid
      end
    end

    context "When fileds left empty" do
      let(:message) { build(:message)}
      
      it "creates message if body is empty" do
        message.body = ""
        expect(message).not_to be_valid
      end

      it "creates message if body is empty" do
        message.user = nil
        expect(message).not_to be_valid
      end
    end
  end
end
