class ChatsController < ApplicationController

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
        format.html { redirect_to @chat } # HTMLで返す場合、showアクションを実行し詳細ページを表示
        format.js  # create.js.erbが呼び出される
      else
        format.html { render :show } # HTMLで返す場合、show.html.erbを表示
      end
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
