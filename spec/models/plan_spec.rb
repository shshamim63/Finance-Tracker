require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe "Validates plan" do

    context "when fields contain all required info" do
      let(:plan) { build(:plan) }
      it "When plan has name, price" do
        expect(plan).to be_valid
      end
    end

    context "when fields do not contain all required info" do
      let(:plan) { build(:plan) }
      it "plan name is nil" do
        plan.name = ""
        expect(plan).not_to be_valid
      end

      it "plan price is nil" do
        plan.price = nil
        expect(plan).not_to be_valid
      end
    end
  end
end
