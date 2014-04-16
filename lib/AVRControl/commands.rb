module AVRControl

  module Commands
    COMMANDS = {
        :power_on => {:string => 'PWON'},
        :power_off => {:string => 'PWSTANDBYF'},
        :power_query => {:string => 'PW?'},
        :main_on => {:string => 'ZMON'},
        :main_off => {:string => 'ZMOFF'},
        :main_query => {:string => 'ZM?'},
        :main_volume_up => {:string => 'MVUP'},
        :main_volume_down => {:string => 'MVDOWN'},
        :main_volume_set => {:string => 'MV', :params => 1, :compound => true},
        :main_volume_query => {:string => 'MV?'},
    }
    COMMANDS.freeze
  end
  include Commands
end
