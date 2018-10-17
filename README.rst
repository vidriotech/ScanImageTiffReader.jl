.. image:: https://gitlab.com/vidriotech/scanimagetiffreader-julia/badges/master/pipeline.svg
   :target: https://gitlab.com/vidriotech/scanimagetiffreader-julia/commits/master
   :alt: Pipeline status

.. image:: https://gitlab.com/vidriotech/scanimagetiffreader-julia/badges/master/coverage.svg
   :target: https://gitlab.com/vidriotech/scanimagetiffreader-julia/commits/master
   :alt: Coverage

About
=====

The ScanImageTiffReader_ is a command line tool and library for extracting data
from Tiff_ and BigTiff_ files recorded using ScanImage_.  It is a very fast tiff
reader and provides access to ScanImage-specific metadata.  It should read most
tiff files, but as of now we don't support compressed or tiled data. This is the
Julia_ interface.  It is also available for Matlab_ and Python_.

More information can be found on scanimage.org_.

Both ScanImage_ and this reader are products of `Vidrio Technologies`_.  If you
have questions or need support feel free to email_.

.. _ScanImageTiffReader: http://scanimage.gitlab.io/ScanImageTiffReaderDocs/
.. _Tiff: https://en.wikipedia.org/wiki/Tagged_Image_File_Format
.. _BigTiff: http://bigtiff.org/
.. _ScanImage: http://scanimage.org
.. _scanimage.org: http://scanimage.org
.. _Python: https://www.python.org
.. _Matlab: https://www.mathworks.com/
.. _Julia: http://julialang.org
.. _`Vidrio Technologies`: http://vidriotechnologies.com/
.. _email: support@vidriotech.com

Examples
========

Julia
``````

.. code-block:: julia

    using ScanImageTiffReader
    vol = ScanImageTiffReader.open("my.tif", data)
