using ScanImageTiffReader
using Test
using DotEnv

DotEnv.config()

testbase = ENV["TESTBASE"]

@testset "failures" begin
    filename = "/not/a/file"
    @test_throws Exception ScanImageTiffReader.open(filename, size)
end

@testset "9ketamineoriginalcropped.tif" begin
    filename = joinpath(testbase, "9ketamineoriginalcropped.tif")
    # $ ScanImageTiffReader image shape 9ketamineoriginalcropped.tif
    # Shape: 119 x 114 x 300 @ i16
    tsize = ScanImageTiffReader.open(filename, size)
    @test tsize == (119, 114, 300)
    ttype = ScanImageTiffReader.open(filename, pxtype)
    # @test ttype == Int16

    # $ ScanImageTiffReader image bytes 9ketamineoriginalcropped.tif
    # 7.76253 MB
    dat = ScanImageTiffReader.open(filename, data)
    @test abs(sizeof(dat)/2^20 - 7.76253) < 1e-5
    @test ScanImageTiffReader.open(filename, length) == size(dat, 3)

    # $ ScanImageTiffReader descriptions --frame 1 9ketamineoriginalcropped.tif
    # ImageJ=1.49v
    # images=300
    # slices=300
    # cf=0
    # c0=-32768.0
    # c1=1.0
    # vunit=Gray Value
    # loop=false
    # min=32556.0
    # max=34238.0
    desc = split(ScanImageTiffReader.open(filename, description, 1))
    @test desc[1] == "ImageJ=1.49v"
    @test desc[2] == "images=300"
    @test desc[3] == "slices=300"
    @test desc[4] == "cf=0"
    @test desc[5] == "c0=-32768.0"
    @test desc[6] == "c1=1.0"
    @test desc[7] == "vunit=Gray"
    @test desc[8] == "Value"
    @test desc[9] == "loop=false"
    @test desc[10] == "min=32556.0"
    @test desc[11] == "max=34238.0"
end
@testset "BigTIFF.tif" begin
end
@testset "BigTIFFLong.tif" begin
end
@testset "BigTIFFLong8.tif" begin
end
@testset "BigTIFFMotorola.tif" begin
end
@testset "BigTIFFMotorolaLongStrips.tif" begin
end
@testset "BigTIFFSubIFD4.tif" begin
end
@testset "BigTIFFSubIFD8.tif" begin
end
@testset "Classic.tif" begin
end
@testset "TR_003.tif" begin
end
@testset "lin_00001.tif" begin
end
@testset "linfree_00001.tif" begin
end
@testset "linfreej_00001.tif" begin
end
@testset "linj_00001.tif" begin
end
@testset "oldfmt.tif" begin
end
@testset "oldfmtj.tif" begin
end
@testset "res_00001.tif" begin
end
@testset "resfree_00001.tif" begin
end
@testset "resfreej_00001.tif" begin
end
@testset "resj_00001.tif" begin
end
@testset "single_image_si.tif" begin
end
