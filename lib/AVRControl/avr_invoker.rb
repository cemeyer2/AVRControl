require 'socket'

module AVRControl

  class AVRInvoker

    def initialize(context)
      @context = context
    end

    def invoke(command)
      begin
        TCPSocket.open(@context.host, 23) do |sock|
          sock.write command.to_s
          sock.flush
          if command.response?
            sleep 0.5
            begin
              command.response = sock.recv_nonblock(1024).chomp
            rescue => e
              return false
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