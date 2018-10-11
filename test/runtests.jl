using ScanImageTiffReader
using Test
using DotEnv
using JSON

DotEnv.config()

testbase = ENV["TESTBASE"]

@testset "failures" begin
    filename = "/not/a/file"
    @test_throws Exception ScanImageTiffReader.open(filename, size)
end

include("test_9ketamineoriginalcropped.jl")
include("test_BigTIFF.jl")
include("test_BigTIFFLong.jl")
include("test_BigTIFFLong8.jl")
include("test_BigTIFFMotorola.jl")
include("test_BigTIFFMotorolaLongStrips.jl")
include("test_BigTIFFSubIFD4.jl")
include("test_BigTIFFSubIFD8.jl")
include("test_Classic.jl")
include("test_TR_003.jl")
include("test_lin_00001.jl")
include("test_linfree_00001.jl")
include("test_linfreej_00001.jl")
include("test_linj_00001.jl")
include("test_oldfmt.jl")
include("test_oldfmtj.jl")
include("test_res_00001.jl")
include("test_resfree_00001.jl")
include("test_resfreej_00001.jl")
include("test_resj_00001.jl")
include("test_resj_2018a_00002.jl")
include("test_single_image_si.jl")

# @testset "9ketamineoriginalcropped.tif" begin
#     filename = joinpath(testbase, "9ketamineoriginalcropped.tif")
#     # $ ScanImageTiffReader image shape 9ketamineoriginalcropped.tif
#     # Shape: 119 x 114 x 300 @ u16
#     tsize = ScanImageTiffReader.open(filename, size)
#     @test tsize == (119, 114, 300)
#     ttype = ScanImageTiffReader.open(filename, pxtype)
#     @test ttype == UInt16
#
#     # $ ScanImageTiffReader image bytes 9ketamineoriginalcropped.tif
#     # 7.76253 MB
#     dat = ScanImageTiffReader.open(filename, data)
#     @test abs(sizeof(dat)/2^20 - 7.76253) < 1e-5
#     @test ScanImageTiffReader.open(filename, length) == size(dat, 3)
#
#     # $ ScanImageTiffReader descriptions --frame 0 9ketamineoriginalcropped.tif
#     # ImageJ=1.49v
#     # images=300
#     # slices=300
#     # cf=0
#     # c0=-32768.0
#     # c1=1.0
#     # vunit=Gray Value
#     # loop=false
#     # min=32556.0
#     # max=34238.0
#     desc = split(ScanImageTiffReader.open(filename, description, 1))
#     @test desc[1] == "ImageJ=1.49v"
#     @test desc[2] == "images=300"
#     @test desc[3] == "slices=300"
#     @test desc[4] == "cf=0"
#     @test desc[5] == "c0=-32768.0"
#     @test desc[6] == "c1=1.0"
#     @test desc[7] == "vunit=Gray"
#     @test desc[8] == "Value"
#     @test desc[9] == "loop=false"
#     @test desc[10] == "min=32556.0"
#     @test desc[11] == "max=34238.0"
#
#     # $ ScanImageTiffReader metadata 9ketamineoriginalcropped.tif
#     #
#     @test ScanImageTiffReader.open(filename, metadata) == ""
# end
# @testset "BigTIFF.tif" begin
#     filename = joinpath(testbase, "9ketamineoriginalcropped.tif")
#
#     # ScanImageTiffReader metadata BigTIFF.tif
#     #
#     @test ScanImageTiffReader.open(filename, metadata) == ""
# end
# @testset "BigTIFFLong.tif" begin
# end
# @testset "BigTIFFLong8.tif" begin
# end
# @testset "BigTIFFMotorola.tif" begin
# end
# @testset "BigTIFFMotorolaLongStrips.tif" begin
# end
# @testset "BigTIFFSubIFD4.tif" begin
# end
# @testset "BigTIFFSubIFD8.tif" begin
# end
# @testset "Classic.tif" begin
# end
# @testset "TR_003.tif" begin
# end
# @testset "lin_00001.tif" begin
# end
# @testset "linfree_00001.tif" begin
# end
# @testset "linfreej_00001.tif" begin
# end
# @testset "linj_00001.tif" begin
# end
# @testset "oldfmt.tif" begin
# end
# @testset "oldfmtj.tif" begin
# end
# @testset "res_00001.tif" begin
# end
# @testset "resfree_00001.tif" begin
# end
# @testset "resfreej_00001.tif" begin
# end
# @testset "resj_00001.tif" begin
# end
# @testset "resj_2018a_00002.tif" begin
#     filename = joinpath(testbase, "resj_2018a_00002.tif")
#
#     # $ ScanImageTiffReader metadata resj_2018a_00002.tif
#     # {
#     #   "SI": {
#     #     "LINE_FORMAT_VERSION": 1,
#     #     "TIFF_FORMAT_VERSION": 3,
#     #     "VERSION_COMMIT": "3cb14551ff2a74fc2cf001207f1cafb10231ea2f",
#     #     "VERSION_MAJOR": "2018a",
#     #     "VERSION_MINOR": "0",
#     #     "acqState": "grab",
#     #     "acqsPerLoop": 1,
#     #     "extTrigEnable": 0,
#     #     "hBeams": {
#     #       "beamCalibratedStatus": 1,
#     #       "directMode": 0,
#     #       "enablePowerBox": 0,
#     #       "flybackBlanking": 1,
#     #       "interlaceDecimation": 1,
#     #       "interlaceOffset": 0,
#     #       "lengthConstants": "_Inf_",
#     #       "powerBoxEndFrame": "_Inf_",
#     #       "powerBoxStartFrame": 1,
#     #       "powerBoxes": {
#     #         "rect": [0.25,0.25,0.5,0.5],
#     #         "powers": "_NaN_",
#     #         "name": "",
#     #         "oddLines": 1,
#     #         "evenLines": 1
#     #       },
#     #       "powerLimits": 100,
#     #       "powers": 1,
#     #       "pzAdjust": 0,
#     #       "pzCustom": [
#     #         null
#     #       ],
#     #       "stackEndPower": "_NaN_",
#     #       "stackStartPower": "_NaN_",
#     #       "stackUseStartPower": 0,
#     #       "stackUserOverrideLz": 0
#     #     },
#     # [...]
#     md = JSON.parse(ScanImageTiffReader.open(filename, metadata))
#     @test md["SI"]["LINE_FORMAT_VERSION"] == 1
#     @test md["SI"]["TIFF_FORMAT_VERSION"] == 3
#     @test md["SI"]["VERSION_COMMIT"] == "3cb14551ff2a74fc2cf001207f1cafb10231ea2f"
#     @test md["SI"]["VERSION_MAJOR"] == "2018a"
#     @test md["SI"]["VERSION_MINOR"] == "0"
#     @test md["SI"]["acqState"] == "grab" # etc...
#
#     @test md["RoiGroups"]["photostimRoiGroups"]  == nothing
# end
# @testset "single_image_si.tif" begin
# end
