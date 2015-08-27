class LotteriesController < ApplicationController
  before_action :set_lottery, only: [:edit, :update, :show, :destroy, :draw, :presentation]

  def index
    @lotteries = Lottery.all
  end

  def new
    @lottery = Lottery.new
  end

  def create
    @lottery = Lottery.new(lottery_params)

    if @lottery.save
      redirect_to lottery_path(@lottery), notice: I18n.t('messages.created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @lottery.update(lottery_params)
      redirect_to lottery_path(@lottery), notice: I18n.t('messages.updated')
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @lottery.destroy!
    redirect_to lotteries_path, notice: I18n.t('messages.destroyed')
  end

  def draw
    if @lottery.draw
      redirect_to lottery_presentation_path(@lottery), notice: I18n.t('messages.drawed')
    else
      message = "#{I18n.t('messages.failed')}\n#{@lottery.errors.full_messages.join("\n")}"
      redirect_to lottery_path(@lottery), alert: message
    end
  end

  def presentation
    @winners = @lottery.winners
    render layout: "slideshow"
  end

  private

  def lottery_params
    params.require(:lottery).permit(:name, :message_type, :winners_count)
  end

  def set_lottery
    @lottery = Lottery.find(params[:id] || params[:lottery_id])
  end
end
