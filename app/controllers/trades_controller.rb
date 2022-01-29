class TradesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
      @trade = current_user.trades.build(trade_params)
      #select2の挙動により空の配列が入る場合があるため、空の配列を削除
      @trade.platform_ids.reject(&:blank?)
      if @trade.save
        flash[:success] = "投稿しました"
        redirect_to root_url
      else
        render 'static_pages/home'
      end
  end

  def destroy
    Trade.find(params[:id]).destroy
    flash[:success] = "投稿を消去しました"
    redirect_to root_url
  end

  def search
    #モデルに定義したサーチメソッドを呼び出し
    trades = Trade.search(current_user,params[:trade_type],params[:item])
    @trades = trades.paginate(page: params[:page], per_page: 10)
    #JSONファイルをインスタンス変数に格納
    items_json = File.read("#{Rails.public_path}/items.json")
    @items = JSON.load(items_json)
    render  'search'
  end

  private

  def trade_params
    params.require(:trade).permit(:mode, :season, :trade_type, :item_to_want, :item_to_offer, :content, platform_ids: [])
  end

  def correct_user
    @trade = current_user.trades.find_by(id: params[:id])
    redirect_to root_url if @trade.nil?
  end

end