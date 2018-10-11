@testset "oldfmtj.tif" begin
filename = joinpath(testbase, "oldfmtj.tif")
    # $ ScanImageTiffReader image shape oldfmtj.tif
    # Shape: 512 x 512 x 10 @ i16
    tsize = ScanImageTiffReader.open(filename, size)
    @test tsize == (512, 512, 10)
    ttype = ScanImageTiffReader.open(filename, pxtype)
    @test ttype == Int16

    # $ ScanImageTiffReader image bytes oldfmtj.tif
    # 5 MB
    dat = ScanImageTiffReader.open(filename, data)
    @test abs(sizeof(dat)/2^20 - 5.0) < 1e-5
    # @test ScanImageTiffReader.open(filename, length) == size(dat, 3) # TODO: check this assumption

    # $ ScanImageTiffReader descriptions --frame 0 oldfmtj.tif
    # "{"
    # "	"FrameHeader": {"
    # "		"frameNumbers": 1,"
    # "		"acquisitionNumbers": 1,"
    # "		"frameNumberAcquisition": 1,"
    # "		"frameTimestamps_sec": 0.000000000,"
    # "		"acqTriggerTimestamps_sec": -0.000017310,"
    # "		"nextFileMarkerTimestamps_sec": -1.000000000,"
    # "		"endOfAcquisition": 0,"
    # "		"endOfAcquisitionMode": 0,"
    # [...]
    desc = split(ScanImageTiffReader.open(filename, description, 1), "\n")
    @test desc[1] == "{"
    @test desc[2] == "\t\"FrameHeader\": {"
    @test desc[3] == "\t\t\"frameNumbers\": 1,"
    @test desc[4] == "\t\t\"acquisitionNumbers\": 1,"
    @test desc[5] == "\t\t\"frameNumberAcquisition\": 1,"
    @test desc[6] == "\t\t\"frameTimestamps_sec\": 0.000000000,"
    @test desc[7] == "\t\t\"acqTriggerTimestamps_sec\": -0.000017310,"
    @test desc[8] == "\t\t\"nextFileMarkerTimestamps_sec\": -1.000000000,"
    @test desc[9] == "\t\t\"endOfAcquisition\": 0,"
    @test desc[10] == "\t\t\"endOfAcquisitionMode\": 0,"

    # $ ScanImageTiffReader metadata oldfmtj.tif
    #
    # didn't parse for one reason or another...
    md = split(ScanImageTiffReader.open(filename, metadata), "\n")
    @test md[1] == ""
end
