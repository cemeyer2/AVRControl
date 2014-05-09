module AVRControl
  class AVRContext

    attr_reader :host, :port

    def initialize(host, port=23)
      @host = host
      @port = port
    end
  end
end