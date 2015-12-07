#!/usr/bin/ruby

require 'socket'

class Client
  def self.run(*args)
    new(*args).run
  end

  def initialize(server)
    @server = server
  end

  def run
    listen
    send

    response.join
    request.join
  end

  private_class_method :new

  private

  attr_reader :server, :response, :request

  def listen
    @response = Thread.new do
      loop do
        message = server.gets
        puts message
      end
    end
  end

  def send
    @request = Thread.new do
      loop do
        message = gets.chomp
        server.puts message
      end
    end
  end
end

hostname = '127.0.0.1'
port = 2000

Client.run(TCPSocket.open(hostname, port))
