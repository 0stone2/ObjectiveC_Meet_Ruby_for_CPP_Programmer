=begin 
Ruby (Sample07.rb)코드입니다.
=end

require 'ffi'

module RbExt
    extend FFI::Library
    ffi_lib "RbExt"

    attach_function :Init_RbExt, [], :void
    attach_function :DbgString, [:string ], :void
    attach_function :Sum, [:int , :int ], :int 
    # etc.
end

RbExt.Init_RbExt()

nStart = 1
nStop = 10
nSum = RbExt.Sum(nStart, nStop)
RbExt.DbgString("sum(#{nStart}, #{nStop}) : #{nSum}\n")