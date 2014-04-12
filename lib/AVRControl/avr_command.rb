module AVRControl

  class AVRCommand

    def initialize(cmd_string)
      @command = cmd_string
    end

    def append(param)
      @command << " #{param}"
      self
    end

    def to_s
      "#{@command}\r"
    end
  end
end