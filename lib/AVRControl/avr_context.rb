module AVRControl
  class AVRContext

    attr_reader :host, :port

    def initialize(host, port=23)
      @host = host
      @port = port
    end

    class << self

      def discover
        Playful.log = false
        results = Playful::SSDP.search 'urn:schemas-upnp-org:device:MediaRenderer:1'
        receivers = []
        results.each do |renderer|
          if renderer.has_key? :server and renderer[:server].include? 'KnOS' #they all run KnOS
            host = URI.parse(renderer[:location]).host
            Timeout::timeout(1) do #check if telnet is open
              begin
                port = 23
                TCPSocket.new(host, port).close
                receivers << AVRContext.new(host, port)
              rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
                next
              end
            end
          end
        end
        sleep 0.5 #need this so that we dont run a command right away, as the receivers tend to crash if hit too often
        receivers
      end
    end
  end
end