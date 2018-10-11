@testset "Classic.tif" begin
filename = joinpath(testbase, "Classic.tif")
    # $ ScanImageTiffReader image shape Classic.tif
    # Shape: 3 x 64 x 64 @ u8
    tsize = ScanImageTiffReader.open(filename, size)
    @test tsize == (3, 64, 64)
    ttype = ScanImageTiffReader.open(filename, pxtype)
    @test ttype == UInt8

    # $ ScanImageTiffReader image bytes Classic.tif
    # 12 kB
    dat = ScanImageTiffReader.open(filename, data)
    @test abs(sizeof(dat)/2^10 - 12.0) < 1e-5
    # @test ScanImageTiffReader.open(filename, length) == size(dat, 3) # TODO: check this assumption

    # $ ScanImageTiffReader descriptions --frame 0 Classic.tif
    #
    @test ScanImageTiffReader.open(filename, description, 1) == ""

    # $ ScanImageTiffReader metadata Classic.tif
    #
    @test ScanImageTiffReader.open(filename, metadata) == ""
end
