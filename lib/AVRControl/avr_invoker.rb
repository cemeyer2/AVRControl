require 'net/telnet'

module AVRControl

  class AVRInvoker

    def initialize(host)
      @host = host
    end

    def invoke(command)

      telnet = Net::Telnet::new('Host' => @host,
                                'Timeout' => 10,
                                'Port' => 23,
                                'Binmode' => true,
                                'Prompt' => '',
                                'Telnetmode' => false,
                                'Output_log' => 'out.log')
      sleep 1
      telnet.cmd(command.to_s)
      sleep 1
      telnet.close
    end

  end
end