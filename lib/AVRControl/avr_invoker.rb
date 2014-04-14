require 'net/telnet'
require 'socket'

module AVRControl

  class AVRInvoker

    def initialize(host)
      @host = host
    end

    def invoke(command)
      TCPSocket.open(@host, 23) do |sock|
        sleep 0.3
        sock.puts command.to_s
        sleep 0.3
      end
    end

  end
end