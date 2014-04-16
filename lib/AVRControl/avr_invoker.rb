require 'socket'

module AVRControl

  class AVRInvoker

    def initialize(host)
      @host = host
    end

    def invoke(command)
      begin
        TCPSocket.open(@host, 23) do |sock|
          sock.write command.to_s
          sock.flush
          if command.response?
            sleep 0.5
            begin
              command.response = sock.recv_nonblock 1024
            rescue => e
              #TODO: something here
            end
          end
        end
        return true
      rescue => e
        return false
      end
    end
  end
end