module AVRControl

  class AVRCommand

    def initialize(cmd_string, required_parameters=0)
      @command = cmd_string
      @required_parameters = required_parameters
    end

    def append_param(param)
      self unless @required_parameters > 0
      @required_parameters -= 1
      @command << " #{param}"
      self
    end

    def to_s
      raise ArgumentError.new('Not enough parameters') unless @required_parameters.zero?
      "#{@command}\r"
    end
  end
end