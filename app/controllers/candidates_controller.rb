class CandidatesController < ApplicationController
  before_action :set_lottery

  def index
  end

  def edit
    build_new_candidates
  end

  def update
    if @lottery.update(candidates_params)
      redirect_to lottery_candidates_path(lottery: @lottery), notice: I18n.t('messages.updated')
    else
      build_new_candidates
      render :edit
    end
  end

  private

  def candidates_params
    params.require(:lottery).permit(candidates_attributes: [:id, :name, :weight, :_destroy])
  end

  def set_lottery
    @lottery = Lottery.find(params[:lottery_id])
  end

  def build_new_candidates
    10.times { @lottery.candidates.build }
  end
end
