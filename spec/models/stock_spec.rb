require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe "validate stock" do

    context "when fields contain all required info" do
      let(:stock) { build(:stock) }
      it "When stock has ticker, name, last_price" do
        expect(stock).to be_valid
      end
    end

    context "when fields do not contain all required info" do
      let(:stock) { build(:stock) }
      it "When stock name is nil" do
        stock.name=""
        expect(stock).not_to be_valid
      end

      it "When stock ticker is nil" do
        stock.ticker=""
        expect(stock).not_to be_valid
      end
      
      it "When stock last_price is nil" do
        stock.last_price=""
        expect(stock).not_to be_valid
      end
    end
  end
end
