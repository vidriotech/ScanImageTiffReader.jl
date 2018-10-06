#=Copyright 2016 Vidrio Technologies, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
=#
module ScanImageTiffReader
export open,size,pxtype,data,length,description,metadata

struct Context
  handle::Ptr{Cvoid}
  log::Ptr{UInt8}
end

struct strides_array
  strides_0::Int64
  strides_1::Int64
  strides_2::Int64
  strides_3::Int64
  strides_4::Int64
  strides_5::Int64
  strides_6::Int64
  strides_7::Int64
  strides_8::Int64
  strides_9::Int64
  strides_10::Int64
end

struct dims_array
  dims_0::UInt64
  dims_1::UInt64
  dims_2::UInt64
  dims_3::UInt64
  dims_4::UInt64
  dims_5::UInt64
  dims_6::UInt64
  dims_7::UInt64
  dims_8::UInt64
  dims_9::UInt64
end

struct Size
  ndim::UInt32
  typeid::Int32
  strides::strides_array
  dims::dims_array
end

libname=@static if Sys.iswindows()
  "ScanImageTiffReaderAPI.dll"
else
  "libScanImageTiffReaderAPI.so"
end

function open(f::Function,filename::AbstractString)
  h=@eval ccall( (:ScanImageTiffReader_Open,$(libname)),Context,(Ptr{UInt8},),$(filename))
  if h.log!=C_NULL
    throw(ErrorException(bytestring(h.log)))
  end
  try
    f(h)
  finally
    @eval ccall( (:ScanImageTiffReader_Close,$(libname)),Cvoid,(Context,),$(h))
  end
end

function size(ctx::Context)
  s=@eval ccall( (:ScanImageTiffReader_GetShape,$(libname)),Size,(Context,),$(ctx))
  if ctx.log!=C_NULL
    throw(ErrorException(bytestring(ctx.log)))
  end
  out=Array{Int}(s.ndim)
  for i=1:s.ndim
    out[i]=s.dims.(i)
  end
  out
end

function pxtype(ctx::Context)
  s=@eval ccall( (:ScanImageTiffReader_GetShape,$(libname)),Size,(Context,),$(ctx))
  if ctx.log!=C_NULL
    throw(ErrorException(bytestring(ctx.log)))
  end
  [UInt8,UInt16,UInt32,UInt64,
   Int8,  Int16, Int32, Int64,
   Float32, Float64][s.typeid+1] # julia is 1-based
 end

function data(ctx::Context)
  out=Array(pxtype(ctx),size(ctx)...)
  @eval ccall( (:ScanImageTiffReader_GetData,$(libname)),Int,
        (Context,Ptr{Cvoid},Csize_t),
        $(ctx),$(out),sizeof($(out)))
  if ctx.log!=C_NULL
    throw(ErrorException(bytestring(ctx.log)))
  end
  out
end

function length(ctx::Context)
  n=@eval ccall( (:ScanImageTiffReader_GetImageDescriptionCount,$(libname)),Int32,(Context,),$(ctx))
  if ctx.log!=C_NULL
    throw(ErrorException(bytestring(ctx.log)))
  end
  n
end

function description(ctx::Context,iframe)
  sz=@eval ccall( (:ScanImageTiffReader_GetImageDescriptionSizeBytes,$(libname)),Csize_t,
        (Context,Cint),
        $(ctx),$(iframe)-1) # convert to zero based
  sz!=0 || return ""
  str=zeros(UInt8,sz)
  @eval ccall( (:ScanImageTiffReader_GetImageDescription,$(libname)),Csize_t,
        (Context,Cint,Ptr{UInt8},Csize_t),
        $(ctx),$(iframe)-1,$(str),sizeof($(str))) # convert to zero based
  if ctx.log!=C_NULL
    throw(ErrorException(bytestring(ctx.log)))
  end
  bytestring(str)
end

function metadata(ctx::Context)
  sz=@eval ccall( (:ScanImageTiffReader_GetMetadataSizeBytes,$(libname)),Csize_t,(Context,),$(ctx))
  sz!=0 || return ""
  str=zeros(UInt8,sz)
  @eval ccall( (:ScanImageTiffReader_GetMetadata,$(libname)),Csize_t,
        (Context,Ptr{UInt8},Csize_t),
        $(ctx),$(str),sizeof($(str)))
  if ctx.log!=C_NULL
    throw(ErrorException(bytestring(ctx.log)))
  end
  bytestring(str)
end

function example()
  filename="../../../data/resj_00001.tif"
  open(filename) do h
    println("hi")
    println(size(h))
    println(pxtype(h))
    println(Base.size(data(h)))
    for i=1:length(h)
      println(description(h,i))
    end
    println(metadata(h))
  end
end

end
