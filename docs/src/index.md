# ScanImageTiffReader.jl Documentation

```@meta
DocTestSetup  = quote
    using Pkg
    Pkg.add("JSON")
    using ScanImageTiffReader, JSON
end
```

[Download ScanImageTiffReader](http://scanimage.vidriotechnologies.com/display/SIH/Tools)

## About

The ScanImageTiffReader reads data from
[Tiff](https://en.wikipedia.org/wiki/Tagged_Image_File_Format) and
[BigTiff](http://bigtiff.org/) files recorded using
[ScanImage](http://scanimage.org). It was written with performance in
mind and provides access to ScanImage-specific metadata. Interfaces to
the library can be found for [Julia](https://julialang.org),
[Python](https://www.python.org), and
[Matlab](https://www.mathworks.com/).
This library should actually work with most tiff files, but as of now we
don't support compressed or tiled data.

Binaries can be downloaded from [scanimage.org](http://scanimage.org)
for 64-bit versions of Windows, OS X, or Linux.

Both [ScanImage](http://scanimage.org) and this reader are products of
[Vidrio Technologies](http://vidriotechnologies.com/). If you have
questions or need support feel free to [email](mailto:support@vidriotech.com).

## Usage

```julia
julia> using ScanImageTiffReader
julia> vol = ScanImageTiffReader.open("my.tif", data) #
```

## API Documentation

```@autodocs
Modules = [ScanImageTiffReader]
Order = [:function, :type]
```
