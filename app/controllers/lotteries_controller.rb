class LotteriesController < ApplicationController
  before_action :set_lottery, only: [:edit, :update, :show]

  def index
    # TODO: implement
  end

  def new
    @lottery = Lottery.new
  end

  def create
    @lottery = Lottery.new(lottery_params)

    if @lottery.save
      redirect_to lottery_path(@lottery.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @lottery.update(lottery_params)
      redirect_to lottery_path(@lottery.id)
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    # TODO: implement
  end

  private

  def lottery_params
    params.require(:lottery).permit(:name, :winners_count)
  end

  def set_lottery
    @lottery = Lottery.find(params[:id])
  end
end
