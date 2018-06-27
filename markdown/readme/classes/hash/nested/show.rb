require 'debug_helper'

hasn = {
    :a => {
        :b => 0,
        :c => 1,
    }
}
DebugHelper.show(hash, 'My nested hash')
