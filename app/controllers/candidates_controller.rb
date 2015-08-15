class CandidatesController < ApplicationController
  before_action :set_lottery

  def index
    # TODO: implement
  end

  def edit
    10.times { @lottery.candidates.build }
  end

  def update
    if @lottery.update(candidates_params)
      redirect_to lottery_candidates_path(lottery: @lottery), notice: I18n.t('messages.updated')
    else
      render :edit
    end
  end

  private

  def candidates_params
    params.require(:lottery).permit(candidates_attributes: [:id, :name, :weight])
  end

  def set_lottery
    @lottery = Lottery.find(params[:lottery_id])
  end
end
