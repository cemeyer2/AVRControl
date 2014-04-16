module AVRControl

  module Commands
    COMMANDS = {
        :power_on => {:string => 'PWON'},
        :power_off => {:string => 'PWSTANDBYF'},
        :power_query => {:string => 'PW?'},
        :main_on => {:string => 'ZMON'},
        :main_off => {:string => 'ZMOFF'},
        :main_query => {:string => 'ZM?'},
    }
    COMMANDS.freeze
  end
  include Commands
end
