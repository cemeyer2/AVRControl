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
        :front_left_volume_up => {:string => 'CVFL UP'},
        :front_left_volume_down => {:string => 'CVFL DOWN'},
        :front_left_volume_set => {:string => 'CVFL', :params => 1},
        :front_right_volume_up => {:string => 'CVFR UP'},
        :front_right_volume_down => {:string => 'CVFR DOWN'},
        :front_right_volume_set => {:string => 'CVFR', :params => 1},
        :center_volume_up => {:string => 'CVC UP'},
        :center_volume_down => {:string => 'CVC DOWN'},
        :center_volume_set => {:string => 'CVC', :params => 1},
        :subwoofer_volume_up => {:string => 'CVSW UP'},
        :subwoofer_volume_down => {:string => 'CVSW DOWN'},
        :subwoofer_volume_set => {:string => 'CVSW', :params => 1},
        :surround_left_volume_up => {:string => 'CVSL UP'},
        :surround_left_volume_down => {:string => 'CVSL DOWN'},
        :surround_left_volume_set => {:string => 'CVSL', :params => 1},
        :surround_right_volume_up => {:string => 'CVSR UP'},
        :surround_right_volume_down => {:string => 'CVSR DOWN'},
        :surround_right_volume_set => {:string => 'CVSR', :params => 1},
        :back_left_volume_up => {:string => 'CVBL UP'},
        :back_left_volume_down => {:string => 'CVBL DOWN'},
        :back_left_volume_set => {:string => 'CVBL', :params => 1},
        :back_right_volume_up => {:string => 'CVBR UP'},
        :back_right_volume_down => {:string => 'CVBR DOWN'},
        :back_right_volume_set => {:string => 'CVBR', :params => 1},
        :back_volume_up => {:string => 'CVSB UP'},
        :back_volume_down => {:string => 'CVSB DOWN'},
        :back_volume_set => {:string => 'CVSB', :params => 1},
    }
    COMMANDS.freeze
  end
  include Commands
end
