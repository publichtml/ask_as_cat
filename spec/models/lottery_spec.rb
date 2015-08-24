require "rails_helper"

describe "Lottery" do
  describe "#draw" do
    let(:lottery) { FactoryGirl.create(:lottery, candidates: FactoryGirl.create_list(:candidate, 3), winners_count: winners_count, drawn: drawn) }
    let(:winners_count) { 2 }

    context "抽選済みでないとき" do
      let(:drawn) { false }

      it "抽選済みとなり、当選者が選ばれている" do
        expect do
          lottery.draw
        end.to change { lottery.drawn }.from(false).to(true).and change { lottery.candidates.winners.count }.from(0).to(winners_count)
      end
    end

    context "抽選済みのとき" do
      let(:drawn) { true }

      it "検証エラーとなる" do
        expect do
          lottery.draw
        end.to_not change { lottery.drawn }.from(true)
        expect(lottery.candidates.winners.count).to eq 0
        expect(lottery.errors[:base].count).to eq 1
      end
    end
  end
end
