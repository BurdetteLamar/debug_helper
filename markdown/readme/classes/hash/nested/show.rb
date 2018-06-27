require 'debug_helper'

hash = {
    :a => {
        :b => 0,
        :c => 1,
    }
}
DebugHelper.show(hash, 'My nested hash')
