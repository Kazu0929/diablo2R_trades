class ChatsController < ApplicationController
  before_action :logged_in_user, only: [:create, :show]

  def show
    #チャット相手の情報を取得
    @user = User.find(params[:id])
    #自分の全てのチャットルームidを取得
    rooms = current_user.user_rooms.pluck(:room_id)
    #チャット相手とのルームがあるか確認
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    #ルームがなかった場合
    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
    else
      #ルームがあった場合
      @room = user_rooms.room
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.build(chat_params)
    @chat.save

    respond_to do |format|
      if @chat.save
        format.html { redirect_to @chat }
        format.js
      else
        format.html { render :show }
      end
    end
  end

  def destroy
    chat = Chat.find(params[:id])
    chat.destroy
    flash[:success] = "メッセージを消去しました"
    redirect_to chat_path(chat.room_id)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
