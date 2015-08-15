class CandidatesController < ApplicationController
  before_action :set_lottery

  def index
    # TODO: implement
  end

  def edit
    10.times { @lottery.candidates.build }
  end

  private

  def set_lottery
    @lottery = Lottery.find(params[:lottery_id])
  end
end
