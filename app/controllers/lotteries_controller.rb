class LotteriesController < ApplicationController
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
    # TODO: implement
  end

  def update
    # TODO: implement
  end

  def show
    # TODO: implement
  end

  def destroy
    # TODO: implement
  end

  private

  def lottery_params
    params.require(:lottery).permit(:name, :winners_count)
  end
end
