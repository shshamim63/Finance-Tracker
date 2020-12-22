class ChatroomController < ApplicationController
  def index
    @message =Message.new
    @messages = Message.last(3)
  end
end