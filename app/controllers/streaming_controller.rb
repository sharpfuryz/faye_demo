require 'eventmachine'
class StreamingController < ApplicationController

  def online
    EM.run {
      client = Faye::Client.new('http://localhost:9292/faye')
      client.publish('/items', 'text' => 'Just another random text')
    }
  end
end