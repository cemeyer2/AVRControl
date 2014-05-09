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
          if renderer.has_key? :server and renderer[:server].include? 'KnOS'
            receivers << AVRContext.new(URI.parse(renderer[:location]).host)
          end
        end
        receivers
      end
    end
  end
end