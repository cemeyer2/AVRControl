module AVRControl

  class AVRCommand

    attr_accessor :response

    def initialize(cmd_string, required_parameters=0)
      @command = [cmd_string.to_s]
      @required_parameters = required_parameters.to_i
    end

    def <<(param)
      self unless @required_parameters > 0
      @required_parameters -= 1
      @command << param
      self
    end

    def to_s
      raise ArgumentError.new('Not enough parameters') unless @required_parameters.zero?
      "#{@command.join(' ')}\r".encode('ASCII')
    end

    def response?
      to_s.include? '?'
    end

    def param_count
      @command.length - 1
    end

    class << self
      def for sym
        hash = AVRControl::COMMANDS[sym]
        raise ArgumentError.new('Command not found') if hash.nil?
        params = hash[:params] ||= 0
        if hash[:compound]
          AVRCompoundCommand.new hash[:string], params
        else
          self.new hash[:string], params
        end
      end
    end
  end

  class AVRCompoundCommand < AVRCommand
    def to_s
      raise ArgumentError.new('Not enough parameters') unless @required_parameters.zero?
      "#{@command.first}#{@command.drop(1).join(' ')}\r".encode('ASCII')
    end
  end
end