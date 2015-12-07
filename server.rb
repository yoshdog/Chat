#!/usr/bin/ruby

require 'socket'

class Server
  def self.run(*args)
    new(*args).run
  end

  def initialize(server)
    @server = server
    @clients = {}
  end

  private_class_method :new

  def run
    loop do
      Thread.start(server.accept) do |client|
        puts "CLIENT CONNECTED"
        client.puts "Hey whats your name?: "
        name = client.gets.chomp
        client.puts "Hey #{name}, welcome"

        clients.store(name, client)
        loop do
          message = client.gets.chomp

          clients.each do |_, c|
            c.puts "#{name} > #{message}"
          end
        end
      end
    end
  end

  private

  attr_reader :server, :clients
end

Server.run(TCPServer.open(2000))
