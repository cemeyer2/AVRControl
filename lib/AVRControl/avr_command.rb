module AVRControl

  class AVRCommand

    attr_accessor :response

    def initialize(cmd_string, required_parameters=0)
      @command = cmd_string
      @required_parameters = required_parameters
    end

    def <<(param)
      self unless @required_parameters > 0
      @required_parameters -= 1
      @command << " #{param}"
      self
    end

    def to_s
      raise ArgumentError.new('Not enough parameters') unless @required_parameters.zero?
      "#{@command}\r".encode('ASCII')
    end

    def response?
      to_s.include? '?'
    end

    class << self
      def for sym
        if AVRControl::COMMANDS.has_key? sym
          hash = AVRControl::COMMANDS[sym]
          params = hash[:params] ||= 0
          self.new hash[:string], params
        else
          nil
        end
      end
    end
  end
end