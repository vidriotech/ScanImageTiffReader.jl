# ScanImageTiffReader.jl Documentation

```@meta
DocTestSetup  = quote
    using Pkg
    Pkg.add("JSON")
    using ScanImageTiffReader, JSON
end
```

## About

The [ScanImageTiffReader] is a [Julia] library for extracting data from [Tiff] and [BigTiff] files recorded using [ScanImage].  It is a very fast tiff reader and provides access to ScanImage-specific metadata.  It should read most tiff files, but as of now we don't support compressed or tiled data.  It is also available as a [Matlab], [Python],  or [C library].  There's also a [command-line interface].

More information and related tools can be found on [here](http://scanimage.vidriotechnologies.com/display/SIH/Tools).

Both [ScanImage] and this reader are products of [Vidrio Technologies].  If you
have questions or need support feel free to [email].

## Usage

```julia
julia> using Pkg
julia> Pkg.add("ScanImageTiffReader")
julia> using ScanImageTiffReader
julia> vol = ScanImageTiffReader.open("my.tif", data) 
```

## API Documentation

```@autodocs
Modules = [ScanImageTiffReader]
Order = [:function, :type]
```


[C library]: https://vidriotech.gitlab.io/scanimagetiffreader
[command-line interface]: https://vidriotech.gitlab.io/scanimagetiffreader
[ScanImageTiffReader]: https://vidriotech.gitlab.io/scanimagetiffreader-julia/
[Tiff]: https://en.wikipedia.org/wiki/Tagged_Image_File_Format
[BigTiff]: http://bigtiff.org/
[ScanImage]: http://scanimage.org
[scanimage.org]: http://scanimage.org
[Python]: https://www.python.org
[Matlab]: https://www.mathworks.com/
[Julia]: https://julialang.org
[Vidrio Technologies]: http://vidriotechnologies.com/
[email]: support@vidriotech.com
[documentation]: https://vidriotech.gitlab.io/scanimagetiffreader-julia/