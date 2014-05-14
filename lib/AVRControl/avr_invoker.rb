require 'socket'

module AVRControl

  class AVRInvoker

    def initialize(context)
      @context = context
    end

    def invoke(command)
      begin
        TCPSocket.open(@context.host, @context.port) do |sock|
          sock.write command.to_s
          sock.flush
          if command.response?
            sleep 0.5
            begin
              command.response = sock.recv_nonblock(1024).chomp
            rescue => e
              command.response = e.message
              return false
            end
          end
        end
        sleep 0.5
        return true
      rescue => e
        command.response = e.message
        sleep 0.5
        return false
      end
    end
  end
end