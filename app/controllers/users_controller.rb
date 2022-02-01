class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @trades = @user.trades.paginate(page: params[:page], per_page: 10)
    #マッチングしたアイテムデータを格納
    @match_trades = User.find_match_items(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.platform_ids.reject(&:blank?)
    if @user.save
      log_in @user
      flash[:success] = "登録に成功しました。ようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを編集しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを消去しました"
    redirect_to users_url
  end

  private
  #ストロングパラメーターズ
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, platform_ids: [])
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
