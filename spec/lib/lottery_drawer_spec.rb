require "rails_helper"

describe "LotteryDrawer" do
  describe "::LotPieces" do
    describe "#pieces" do
      subject { LotteryDrawer::LotPieces.new(candidates).instance_variable_get(:@pieces) }

      context "候補が空のとき" do
        let(:candidates) { [] }

        it "空配列を返す" do
          is_expected.to eq []
        end
      end

      context "候補のweightがすべて1のとき" do
        let(:candidates) do
          [
            FactoryGirl.create(:candidate, weight: 1),
            FactoryGirl.create(:candidate, weight: 1),
            FactoryGirl.create(:candidate, weight: 1)
          ]
        end

        it "各候補が1つずつ入った配列を返す" do
          is_expected.to match_array candidates
        end
      end

      context "候補のweightが2のものが混じっているとき" do
        let(:candidate1) { FactoryGirl.create(:candidate, weight: 2) }
        let(:candidate2) { FactoryGirl.create(:candidate, weight: 2) }
        let(:candidate3) { FactoryGirl.create(:candidate, weight: 1) }
        let(:candidates) { [candidate1, candidate2, candidate3] }

        it "weightが2の候補が2つ、他は1つ入った配列を返す" do
          is_expected.to match_array [candidate1, candidate1, candidate2, candidate2, candidate3]
        end
      end
    end

    describe "#draw_one" do

      context "候補が空のとき" do
        subject { LotteryDrawer::LotPieces.new(candidates).draw_one }
        let(:candidates) { [] }

        it "nilを返す" do
          is_expected.to be_nil
        end
      end

      context "候補が空でないとき" do
        subject do
          pieces = LotteryDrawer::LotPieces.new(candidates)
          (0...winners_count).map { pieces.draw_one }
        end

        let(:candidates) do
          [
            FactoryGirl.create(:candidate, weight: 1),
            FactoryGirl.create(:candidate, weight: 1),
            FactoryGirl.create(:candidate, weight: 1)
          ]
        end
        let(:winners_count) { 4 }

        it "最初の候補数回は候補を重複なく返し、それ以降はnilを返す" do
          expect(subject[0, 3]).to match_array candidates
          expect(subject[4]).to be_nil
        end
      end
    end
  end

  describe ".draw" do
    subject { LotteryDrawer.draw(candidates, winners_count) }

    context "候補が0人のとき" do
      let(:candidates) { [] }
      let(:winners_count) { 2 }

      it "空配列を返す" do
        is_expected.to eq []
      end
    end

    context "候補数より当選者数の方が多いとき" do
      let(:candidates) { (0..1).map { |i| FactoryGirl.create(:candidate) } }
      let(:winners_count) { 3 }

      it "全候補の入った配列を返す" do
        is_expected.to match_array candidates
      end
    end

    context "候補数より当選者数の方が少ないとき" do
      let(:candidates) { (0..5).map { |i| FactoryGirl.create(:candidate) } }
      let(:winners_count) { 3 }

      it "winners_count個の候補の入った配列を返す" do
        expect(subject.size).to eq winners_count
        # 引き算できて要素がwinners_count個だけ減れば、subjectの要素は重複のない候補者instanceだったことになる
        expect((candidates - subject).size).to eq (candidates.size - winners_count)
      end
    end

    context "候補者にweightが2の候補が混じっているとき" do
      let(:candidates) { (0..1).map { |i| FactoryGirl.create(:candidate, weight: 2) } }
      let(:winners_count) { 4 } # 重複排除機能がなければ、全候補が2個ずつ選ばれるはず

      it "重複なく候補者を選ぶ" do
        is_expected.to match_array candidates
      end
    end
  end
end
