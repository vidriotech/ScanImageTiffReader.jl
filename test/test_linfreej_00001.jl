@testset "linfreej_00001.tif" begin
filename = joinpath(testbase, "linfreej_00001.tif")
    # $ ScanImageTiffReader image shape linfreej_00001.tif
    # Shape: 512 x 512 x 10 @ i16
    tsize = ScanImageTiffReader.open(filename, size)
    @test tsize == (512, 512, 10)
    ttype = ScanImageTiffReader.open(filename, pxtype)
    @test ttype == Int16

    # $ ScanImageTiffReader image bytes linfreej_00001.tif
    # 5 MB
    dat = ScanImageTiffReader.open(filename, data)
    @test abs(sizeof(dat)/2^20 - 5.0) < 1e-5
    # @test ScanImageTiffReader.open(filename, length) == size(dat, 3) # TODO: check this assumption

    # $ ScanImageTiffReader descriptions --frame 0 linfreej_00001.tif
    # "frameNumbers = 1" 
    # "acquisitionNumbers = 1" 
    # "frameNumberAcquisition = 1" 
    # "frameTimestamps_sec = 0.000000" 
    # "acqTriggerTimestamps_sec = " 
    # "nextFileMarkerTimestamps_sec = " 
    # "endOfAcquisition =  0" 
    # "endOfAcquisitionMode = 0" 
    # "dcOverVoltage = 0" 
    # "epoch = [2016 6 4 13 52 19.66]" 
    desc = split(ScanImageTiffReader.open(filename, description, 1), "\n")
    @test desc[1] == "frameNumbers = 1"
    @test desc[2] == "acquisitionNumbers = 1"
    @test desc[3] == "frameNumberAcquisition = 1"
    @test desc[4] == "frameTimestamps_sec = 0.000000"
    @test desc[5] == "acqTriggerTimestamps_sec = "
    @test desc[6] == "nextFileMarkerTimestamps_sec = "
    @test desc[7] == "endOfAcquisition =  0"
    @test desc[8] == "endOfAcquisitionMode = 0"
    @test desc[9] == "dcOverVoltage = 0"
    @test desc[10] == "epoch = [2016 6 4 13 52 19.66]"

    # $ ScanImageTiffReader metadata linfreej_00001.tif
    # { 
    #   "SI": { 
    #     "TIFF_FORMAT_VERSION": 3, 
    #     "VERSION_MAJOR": "2015", 
    #     "VERSION_MINOR": "4", 
    #     "acqState": "grab", 
    #     "acqsPerLoop": 1, 
    #     "extTrigEnable": 0, 
    #     "hBeams": { 
    #       "beamCalibratedStatus": [0,0,0], 
    # [...]
    # didn't parse for one reason or another...
    md = split(ScanImageTiffReader.open(filename, metadata), "\n")
    @test md[1] == "{"
    @test md[2] == "  \"SI\": {"
    @test md[3] == "    \"TIFF_FORMAT_VERSION\": 3,"
    @test md[4] == "    \"VERSION_MAJOR\": \"2015\","
    @test md[5] == "    \"VERSION_MINOR\": \"4\","
    @test md[6] == "    \"acqState\": \"grab\","
    @test md[7] == "    \"acqsPerLoop\": 1,"
    @test md[8] == "    \"extTrigEnable\": 0,"
    @test md[9] == "    \"hBeams\": {"
    @test md[10] == "      \"beamCalibratedStatus\": [0,0,0],"
end
