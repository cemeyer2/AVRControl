module AVRControl
  class AVRContext

    attr_reader :host

    def initialize(host)
      @host = host
    end
  end
end