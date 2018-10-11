@testset "BigTIFFLong8.tif" begin
filename = joinpath(testbase, "BigTIFFLong8.tif")
    # $ ScanImageTiffReader image shape BigTIFFLong8.tif
    # Shape: 3 x 64 x 64 @ u8
    tsize = ScanImageTiffReader.open(filename, size)
    @test tsize == (3, 64, 64)
    ttype = ScanImageTiffReader.open(filename, pxtype)
    @test ttype == UInt8

    # $ ScanImageTiffReader image bytes BigTIFFLong8.tif
    # 12 kB
    dat = ScanImageTiffReader.open(filename, data)
    @test abs(sizeof(dat)/2^10 - 12.0) < 1e-5
    # @test ScanImageTiffReader.open(filename, length) == size(dat, 3) # TODO: check this assumption

    # $ ScanImageTiffReader descriptions --frame 0 BigTIFFLong8.tif
    #
    @test ScanImageTiffReader.open(filename, description, 1) == ""

    # $ ScanImageTiffReader metadata BigTIFFLong8.tif
    #
    @test ScanImageTiffReader.open(filename, metadata) == ""
end
