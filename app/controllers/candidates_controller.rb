class CandidatesController < ApplicationController
  before_action :set_lottery

  def index
    # TODO: implement
  end

  def edit
    # TODO: implement
  end

  private

  def set_lottery
    @lottery = Lottery.find(params[:lottery_id])
  end
end
