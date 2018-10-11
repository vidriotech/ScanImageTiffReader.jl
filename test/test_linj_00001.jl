@testset "linj_00001.tif" begin
filename = joinpath(testbase, "linj_00001.tif")
    # $ ScanImageTiffReader image shape linj_00001.tif
    # Shape: 512 x 512 x 10 @ i16
    tsize = ScanImageTiffReader.open(filename, size)
    @test tsize == (512, 512, 10)
    ttype = ScanImageTiffReader.open(filename, pxtype)
    @test ttype == Int16

    # $ ScanImageTiffReader image bytes linj_00001.tif
    # 5 MB
    dat = ScanImageTiffReader.open(filename, data)
    @test abs(sizeof(dat)/2^20 - 5.0) < 1e-5
    # @test ScanImageTiffReader.open(filename, length) == size(dat, 3) # TODO: check this assumption

    # $ ScanImageTiffReader descriptions --frame 0 linj_00001.tif
    # "frameNumbers = 1" 
    # "acquisitionNumbers = 1" 
    # "frameNumberAcquisition = 1" 
    # "frameTimestamps_sec = 0.000000" 
    # "acqTriggerTimestamps_sec = " 
    # "nextFileMarkerTimestamps_sec = " 
    # "endOfAcquisition =  0" 
    # "endOfAcquisitionMode = 0" 
    # "dcOverVoltage = 0" 
    # "epoch = [2016 6 4 13 51 7.8046]" 
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
    @test desc[10] == "epoch = [2016 6 4 13 51 7.8046]"

    # $ ScanImageTiffReader metadata linj_00001.tif
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
    md = JSON.parse(ScanImageTiffReader.open(filename, metadata))
    # only descend two levels...
    @test md["SI"]["imagingSystem"] == "LinScanner"
    @test md["SI"]["acqState"] == "grab"
    @test md["SI"]["loopAcqInterval"] == 10
    @test md["SI"]["VERSION_MINOR"] == "4"
    @test md["SI"]["extTrigEnable"] == 0
    @test md["SI"]["TIFF_FORMAT_VERSION"] == 3
    @test md["SI"]["acqsPerLoop"] == 1
    @test md["SI"]["VERSION_MAJOR"] == "2015"
    @test md["SI"]["objectiveResolution"] == 16
    @test md["RoiGroups"]["photostimRoiGroups"] == nothing
end
