@testset "oldfmt.tif" begin
filename = joinpath(testbase, "oldfmt.tif")
    # $ ScanImageTiffReader image shape oldfmt.tif
    # Shape: 512 x 512 x 10 @ i16
    tsize = ScanImageTiffReader.open(filename, size)
    @test tsize == (512, 512, 10)
    ttype = ScanImageTiffReader.open(filename, pxtype)
    @test ttype == Int16

    # $ ScanImageTiffReader image bytes oldfmt.tif
    # 5 MB
    dat = ScanImageTiffReader.open(filename, data)
    @test abs(sizeof(dat)/2^20 - 5.0) < 1e-5
    # @test ScanImageTiffReader.open(filename, length) == size(dat, 3) # TODO: check this assumption

    # $ ScanImageTiffReader descriptions --frame 0 oldfmt.tif
    # "frameNumbers = 1"
    # "acquisitionNumbers = 1"
    # "frameNumberAcquisition = 1"
    # "frameTimestamps_sec = 0.000000000"
    # "acqTriggerTimestamps_sec = -0.000031310"
    # "nextFileMarkerTimestamps_sec = -1.000000000"
    # "endOfAcquisition = 0"
    # "endOfAcquisitionMode = 0"
    # "dcOverVoltage = 0"
    # "epoch = [2016  6  2 20  2 22.065]"
    # [...]
    desc = split(ScanImageTiffReader.open(filename, description, 1), "\n")
    @test desc[1] == "frameNumbers = 1"
    @test desc[2] == "acquisitionNumbers = 1"
    @test desc[3] == "frameNumberAcquisition = 1"
    @test desc[4] == "frameTimestamps_sec = 0.000000000"
    @test desc[5] == "acqTriggerTimestamps_sec = -0.000031310"
    @test desc[6] == "nextFileMarkerTimestamps_sec = -1.000000000"
    @test desc[7] == "endOfAcquisition = 0"
    @test desc[8] == "endOfAcquisitionMode = 0"
    @test desc[9] == "dcOverVoltage = 0"
    @test desc[10] == "epoch = [2016  6  2 20  2 22.065]"

    # $ ScanImageTiffReader metadata oldfmt.tif
    #
    # didn't parse for one reason or another...
    md = split(ScanImageTiffReader.open(filename, metadata), "\n")
    @test md[1] == ""
end
