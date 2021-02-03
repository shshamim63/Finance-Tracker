# frozen_string_literal: true

class ChatroomController < ApplicationController
  def index
    @message = Message.new
    @messages = Message.all
  end
end
