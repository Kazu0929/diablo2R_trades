module SessionsHelper

  #引数に渡されたユーザーでログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  #現在ログインしているユーザーを取得
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  #ログインしているか確認
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
