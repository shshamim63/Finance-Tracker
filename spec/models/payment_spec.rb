require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe "Validates payment" do

    context "when fields contain all required info" do
      let(:payment) { build(:payment) }
      it "When payment has email, token, user_id" do
        expect(payment).to be_valid
      end
    end

    context "when fields do not contain all required info" do
      let(:payment) { build(:payment) }
      it "payment email is nil" do
        payment.email = ""
        expect(payment).not_to be_valid
      end

      it "payment token is nil" do
        payment.token = ""
        expect(payment).not_to be_valid
      end

      it "payment user is nil" do
        payment.user = nil
        expect(payment).not_to be_valid
      end
    end
  end
end
