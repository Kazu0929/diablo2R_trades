class StaticPagesController < ApplicationController

  def home
    @trade = current_user.trades.build if logged_in?
    @trades = Trade.paginate(page: params[:page], per_page: 10)
    items_json = File.read("#{Rails.public_path}/items.json")
    @items = JSON.load(items_json)
  end
end
