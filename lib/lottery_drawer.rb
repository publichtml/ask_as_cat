class LotteryDrawer
  class LotPieces
    def initialize(candidates)
      @pieces = weighted_pieces(candidates)
    end

    def draw_one
      winner = @pieces.sample
      @pieces.delete(winner)
      winner
    end

    private

    def weighted_pieces(candidates)
      candidates.map { |candidate| Array.new(candidate.weight, candidate) }.flatten
    end
  end

  class << self
    def draw(candidates, winners_count)
      pieces = LotPieces.new(candidates)
      winners = []
      winners_count.times { winners << pieces.draw_one }
      winners.compact
    end
  end
end
