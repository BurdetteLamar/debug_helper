require 'ostruct'
require 'debug_helper'

ostruct = OpenStruct.new(
                        :a => OpenStruct.new(
                                            :b => 0,
                                            :c => 1,
                        ),
                        :d => OpenStruct.new(
                                            :e => 2,
                                            :f => 3,
                        )
)
DebugHelper.show(ostruct, 'My nested struct')
