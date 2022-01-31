class StaticPagesController < ApplicationController

  def home
    @trade = current_user.trades.build if logged_in?
    @trades = Trade.paginate(page: params[:page], per_page: 10)
    #アイテムデータを格納
    @items = items_data
  end
end
