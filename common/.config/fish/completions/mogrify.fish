complete -c mogrify -o adjoin                       -d 'Join images into a single multi-image file'
complete -c mogrify -o affine                       -d 'Affine transform matrix [matrix]'
complete -c mogrify -o antialias                    -d 'Remove pixel-aliasing '
complete -c mogrify -o authenticate                 -d 'Decrypt image with this password [value]'
complete -c mogrify -o background                   -d 'Background color [color]' -xa '(__fish_complete_convert_options color)'
complete -c mogrify -o bias                         -d 'Add bias when convolving an image [value]'
complete -c mogrify -o black-point-compensation     -d 'Use black point compensation'
complete -c mogrify -o blue-primary                 -d 'Chromaticity blue primary point [point]'
complete -c mogrify -o bordercolor                  -d 'Border color [color]' -xa '(__fish_complete_convert_options color)'
complete -c mogrify -o caption                      -d 'Assign a caption to an image [string]'
complete -c mogrify -o cdl                          -d 'Color correct with a color decision list [filename]' -r
complete -c mogrify -o channel                      -d 'Apply option to select image channels [type]' -xa '(mogrify -list channel)'
complete -c mogrify -o colors                       -d 'Preferred number of colors in the image [value]'
complete -c mogrify -o colorspace                   -d 'Alternate image colorspace [type]' -xa '(mogrify -list colorspace)'
complete -c mogrify -o comment                      -d 'Annotate image with comment [string]'
complete -c mogrify -o compose                      -d 'Set image composite operator [operator]'
complete -c mogrify -o compress                     -d 'Type of pixel compression when writing the image [type]' -xa '(mogrify -list compress)'
complete -c mogrify -o decipher                     -d 'Convert cipher pixels to plain pixels [filename]' -r
complete -c mogrify -o define                       -d 'Define one or more image format options [format:option]'
complete -c mogrify -o delay                        -d 'Display the next image after pausing [value]'
complete -c mogrify -o density                      -d 'Horizontal and vertical density of the image [geometry]'
complete -c mogrify -o depth                        -d 'Image depth [value]'
complete -c mogrify -o direction                    -d 'Render text right-to-left or left-to-right [type]' -xa '(mogrify -list direction)'
complete -c mogrify -o display                      -d 'Get image or font from this X server [server]'
complete -c mogrify -o dispose                      -d 'Layer disposal method [method]' -xa '(mogrify -list dispose)'
complete -c mogrify -o dither                       -d 'Apply error diffusion to image [method]' -xa '(mogrify -list dither)'
complete -c mogrify -o encipher                     -d 'Convert plain pixels to cipher pixels [filename]' -r
complete -c mogrify -o encoding                     -d 'Encoding type [type text]' -xa '(__fish_print_encodings)'
complete -c mogrify -o endian                       -d 'Endianness (MSB or LSB) of the image [type]' -xa '(mogrify -list endian)'
complete -c mogrify -o family                       -d 'Render text with this font family [name]' -xa '(__fish_complete_convert_options family)'
complete -c mogrify -o fill                         -d 'Color to use when filling a graphic primitive [color]' -xa '(__fish_complete_convert_options color)'
complete -c mogrify -o filter                       -d 'Use this filter when resizing an image [type]' -xa '(mogrify -list filter)'
complete -c mogrify -o flatten                      -d 'Flatten a sequence of images'
complete -c mogrify -o font                         -d 'Render text with this font [name]' -xa '(__fish_complete_convert_options font)'
complete -c mogrify -o format                       -d 'Image format type [type]' -xa '(__fish_complete_convert_options type)'
complete -c mogrify -o function                     -d 'Apply a function to the image [name]' -xa '(mogrify -list function)'
complete -c mogrify -o fuzz                         -d 'Colors within this distance are considered equal [distance]'
complete -c mogrify -o gravity                      -d 'Horizontal and vertical text placement [type]' -xa '(mogrify -list gravity)'
complete -c mogrify -o green-primary                -d 'Chromaticity green primary point [point]'
complete -c mogrify -o intent                       -d 'Type of rendering intent when managing the image color [type]' -xa '(mogrify -list intent)'
complete -c mogrify -o interlace                    -d 'Type of image interlacing scheme [type]' -xa '(mogrify -list interlace)'
complete -c mogrify -o interpolate                  -d 'Pixel color interpolation method [method]' -xa '(mogrify -list interpolate)'
complete -c mogrify -o kerning                      -d 'Set the space between two letters [value]'
complete -c mogrify -o label                        -d 'Assign a label to an image [string]'
complete -c mogrify -o limit                        -d 'Pixel cache resource limit [type value]' -x
complete -c mogrify -o loop                         -d 'Add Netscape loop extension to your GIF animation [iterations]'
complete -c mogrify -o mask                         -d 'Associate a mask with the image [filename]' -r
complete -c mogrify -o matte                        -d 'Store matte channel if the image has one'
complete -c mogrify -o mattecolor                   -d 'Frame color [color]' -xa '(__fish_complete_convert_options color)'
complete -c mogrify -o monitor                      -d 'Monitor progress '
complete -c mogrify -o morphology                   -d 'Apply a morphology method to the image [method kernel]' -xa '(mogrify -list morphology)'
complete -c mogrify -o orient                       -d 'Image orientation [type]' -xa '(mogrify -list orientation)'
complete -c mogrify -o origin                       -d 'Image origin [geometry]'
complete -c mogrify -o page                         -d 'Size and location of an image canvas (setting) [geometry]'
complete -c mogrify -o path                         -d 'Path write images to this path on disk'
complete -c mogrify -o ping                         -d 'Efficiently determine image attributes'
complete -c mogrify -o pointsize                    -d 'Font point size [value]'
complete -c mogrify -o preview                      -d 'Image preview type [type]' -xa '(mogrify -list preview)'
complete -c mogrify -o quality                      -d 'JPEG/MIFF/PNG compression level [value]'
complete -c mogrify -o quiet                        -d 'Suppress all warning messages'
complete -c mogrify -o red-primary                  -d 'Chromaticity red primary point [point]'
complete -c mogrify -o regard-warnings              -d 'Pay attention to warning messages'
complete -c mogrify -o sampling-factor              -d 'Horizontal and vertical sampling factor [geometry]'
complete -c mogrify -o scene                        -d 'Image scene number [value]'
complete -c mogrify -o seed                         -d 'Seed a new sequence of pseudo-random numbers [value]'
complete -c mogrify -o size                         -d 'Width and height of image [geometry]'
complete -c mogrify -o stretch                      -d 'Render text with this font stretch [type]' -xa '(mogrify -list stretch)'
complete -c mogrify -o stroke                       -d 'Graphic primitive stroke color [color]' -xa '(__fish_complete_convert_options color)'
complete -c mogrify -o strokewidth                  -d 'Graphic primitive stroke width [value]'
complete -c mogrify -o style                        -d 'Render text with this font style [type]' -xa '(mogrify -list style)'
complete -c mogrify -o support                      -d 'Resize support: > 1.0 is blurry, < 1.0 is sharp [factor]'
complete -c mogrify -o synchronize                  -d 'Synchronize image to storage device'
complete -c mogrify -o taint                        -d 'Declare the image as modified'
complete -c mogrify -o texture                      -d 'Name of texture to tile onto the image background [filename]' -r
complete -c mogrify -o tile-offset                  -d 'Tile offset [geometry]'
complete -c mogrify -o treedepth                    -d 'Color tree depth [value]'
complete -c mogrify -o transparent-color            -d 'Transparent color [color]' -xa '(__fish_complete_convert_options color)'
complete -c mogrify -o undercolor                   -d 'Annotation bounding box color [color]' -xa '(__fish_complete_convert_options color)'
complete -c mogrify -o units                        -d 'The units of image resolution [type]' -xa '(mogrify -list units)'
complete -c mogrify -o verbose                      -d 'Print detailed information about the image'
complete -c mogrify -o view                         -d 'FlashPix viewing transforms'
complete -c mogrify -o virtual-pixel                -d 'Virtual pixel access method [method]' -xa '(mogrify -list virtual-pixel)'
complete -c mogrify -o weight                       -d 'Render text with this font weight [type]' -x
complete -c mogrify -o white-point                  -d 'Chromaticity white point [point]'
complete -c mogrify -o adaptive-blur                -d 'Adaptively blur pixels; decrease effect near edges [geometry]'
complete -c mogrify -o adaptive-resize              -d 'Adaptively resize image with data dependent triangulation [geometry]'
complete -c mogrify -o adaptive-sharpen             -d 'Adaptively sharpen pixels; increase effect near edges [geometry]'
complete -c mogrify -o annotate                     -d 'Annotate the image with text [geometry text]'
complete -c mogrify -o auto-orient                  -d 'Automatically orient image'
complete -c mogrify -o black-threshold              -d 'Force all pixels below the threshold into black [value]'
complete -c mogrify -o blur                         -d 'Reduce image noise and reduce detail levels [geometry]'
complete -c mogrify -o border                       -d 'Surround image with a border of color [geometry]'
complete -c mogrify -o charcoal                     -d 'Simulate a charcoal drawing [radius]'
complete -c mogrify -o chop                         -d 'Remove pixels from the image interior [geometry]'
complete -c mogrify -o clip                         -d 'Clip along the first path from the 8BIM profile'
complete -c mogrify -o clip-mask                    -d 'Associate a clip mask with the image [filename]' -r
complete -c mogrify -o clip-path                    -d 'Clip along a named path from the 8BIM profile [id]'
complete -c mogrify -o colorize                     -d 'Colorize the image with the fill color [value]'
complete -c mogrify -o color-matrix                 -d 'Apply color correction to the image [matrix]'
complete -c mogrify -o contrast                     -d 'Enhance or reduce the image contrast'
complete -c mogrify -o contrast-stretch             -d 'Improve contrast by `stretching\' the intensity range [geometry]'
complete -c mogrify -o convolve                     -d 'Apply a convolution kernel to the image [coefficients]'
complete -c mogrify -o cycle                        -d 'Cycle the image colormap [amount]'
complete -c mogrify -o despeckle                    -d 'Reduce the speckles within an image'
complete -c mogrify -o draw                         -d 'Annotate the image with a graphic primitive [string]'
complete -c mogrify -o edge                         -d 'Apply a filter to detect edges in the image [radius]'
complete -c mogrify -o emboss                       -d 'Emboss an image [radius]'
complete -c mogrify -o enhance                      -d 'Apply a digital filter to enhance a noisy image'
complete -c mogrify -o equalize                     -d 'Perform histogram equalization to an image'
complete -c mogrify -o evaluate                     -d 'Evaluate an arithmetic, relational, or logical expression [operator value]'
complete -c mogrify -o extent                       -d 'Set the image size [geometry]'
complete -c mogrify -o extract                      -d 'Extract area from image [geometry]'
complete -c mogrify -o fft                          -d 'Implements the discrete Fourier transform (DFT)'
complete -c mogrify -o flip                         -d 'Flip image vertically'
complete -c mogrify -o floodfill                    -d 'Color floodfill the image with color [geometry]'
complete -c mogrify -o flop                         -d 'Flop image horizontally'
complete -c mogrify -o frame                        -d 'Surround image with an ornamental border [geometry]'
complete -c mogrify -o gamma                        -d 'Level of gamma correction [value]'
complete -c mogrify -o gaussian-blur                -d 'Reduce image noise and reduce detail levels [geometry]'
complete -c mogrify -o geometry                     -d 'Preferred size or location of the image [geometry]'
complete -c mogrify -o ift                          -d 'Implements the inverse discrete Fourier transform (DFT)'
complete -c mogrify -o help                         -d 'Print program options'
complete -c mogrify -o identify                     -d 'Identify the format and characteristics of the image'
complete -c mogrify -o implode                      -d 'Implode image pixels about the center [amount]'
complete -c mogrify -o lat                          -d 'Local adaptive thresholding [geometry]'
complete -c mogrify -o layers                       -d 'Optimize or compare image layers [method]' -xa '(mogrify -list layers)'
complete -c mogrify -o level                        -d 'Adjust the level of image contrast [value]'
complete -c mogrify -o linear-stretch               -d 'Improve contrast by `stretching with saturation\' the intensity range [geometry]'
complete -c mogrify -o median                       -d 'Apply a median filter to the image [geometry]'
complete -c mogrify -o mode                         -d 'Make each pixel the \'predominant color\' of the neighborhood [geometry]'
complete -c mogrify -o modulate                     -d 'Vary the brightness, saturation, and hue [value]'
complete -c mogrify -o monochrome                   -d 'Transform image to black and white'
complete -c mogrify -o motion-blur                  -d 'Simulate motion blur [geometry]'
complete -c mogrify -o negate                       -d 'Replace each pixel with its complementary color'
complete -c mogrify -o noise                        -d 'Add or reduce noise in an image [geometry]'
complete -c mogrify -o normalize                    -d 'Transform image to span the full range of colors'
complete -c mogrify -o opaque                       -d 'Change this color to the fill color [color]' -xa '(__fish_complete_convert_options color)'
complete -c mogrify -o ordered-dither               -d 'Add a noise pattern to the image with specific amplitudes [NxN]'
complete -c mogrify -o paint                        -d 'Simulate an oil painting [radius]'
complete -c mogrify -o polaroid                     -d 'Simulate a Polaroid picture [angle]'
complete -c mogrify -o posterize                    -d 'Reduce the image to a limited number of color levels [levels]'
complete -c mogrify -o print                        -d 'Interpret string and print to console [string]'
complete -c mogrify -o profile                      -d 'Add, delete, or apply an image profile [filename]' -r
complete -c mogrify -o quantize                     -d 'Reduce colors in this colorspace [colorspace]' -xa '(mogrify -list colorspace)'
complete -c mogrify -o radial-blur                  -d 'Radial blur the image [angle]'
complete -c mogrify -o raise                        -d 'Lighten/darken image edges to create a 3-D effect [value]'
complete -c mogrify -o random-threshold             -d 'Random threshold the image [low,high]'
complete -c mogrify -o region                       -d 'Apply options to a portion of the image [geometry]'
complete -c mogrify -o render                       -d 'Render vector graphics'
complete -c mogrify -o repage                       -d 'Size and location of an image canvas [geometry]'
complete -c mogrify -o resample                     -d 'Change the resolution of an image [geometry]'
complete -c mogrify -o resize                       -d 'Resize the image [geometry]'
complete -c mogrify -o roll                         -d 'Roll an image vertically or horizontally [geometry]'
complete -c mogrify -o rotate                       -d 'Apply Paeth rotation to the image [degrees]'
complete -c mogrify -o sample                       -d 'Scale image with pixel sampling [geometry]'
complete -c mogrify -o scale                        -d 'Scale the image [geometry]'
complete -c mogrify -o segment                      -d 'Segment an image [values]'
complete -c mogrify -o selective-blur               -d 'Selectively blur pixels within a contrast threshold [geometry]'
complete -c mogrify -o sepia-tone                   -d 'Simulate a sepia-toned photo [threshold]'
complete -c mogrify -o set                          -d 'Set an image property [property value]'
complete -c mogrify -o shade                        -d 'Shade the image using a distant light source [degrees]'
complete -c mogrify -o shadow                       -d 'Simulate an image shadow [geometry]'
complete -c mogrify -o sharpen                      -d 'Sharpen the image [geometry]'
complete -c mogrify -o shave                        -d 'Shave pixels from the image edges [geometry]'
complete -c mogrify -o shear                        -d 'Slide one edge of the image along the X or Y axis [geometry]'
complete -c mogrify -o sigmoidal-contrast           -d 'Lightness rescaling using sigmoidal contrast enhancement [geometry]'
complete -c mogrify -o sketch                       -d 'Simulate a pencil sketch [geometry]'
complete -c mogrify -o solarize                     -d 'Negate all pixels above the threshold level [threshold]'
complete -c mogrify -o splice                       -d 'Splice the background color into the image [geometry]'
complete -c mogrify -o spread                       -d 'Displace image pixels by a random amount [amount]'
complete -c mogrify -o statistic                    -d 'Replace each pixel with corresponding statistic from the neighborhood [type geometry]' -xa '(mogrify -list statistic)'
complete -c mogrify -o strip                        -d 'Strip image of all profiles and comments'
complete -c mogrify -o swirl                        -d 'Swirl image pixels about the center [degrees]'
complete -c mogrify -o threshold                    -d 'Threshold the image [value]'
complete -c mogrify -o thumbnail                    -d 'Create a thumbnail of the image [geometry]'
complete -c mogrify -o tile                         -d 'Tile image when filling a graphic primitive [filename]' -r
complete -c mogrify -o tint                         -d 'Tint the image with the fill color [value]'
complete -c mogrify -o transform                    -d 'Affine transform image'
complete -c mogrify -o transparent                  -d 'Make this color transparent within the image [color]' -xa '(__fish_complete_convert_options color)'
complete -c mogrify -o transpose                    -d 'Flip image vertically and rotate 90 degrees'
complete -c mogrify -o transverse                   -d 'Flop image horizontally and rotate 270 degrees'
complete -c mogrify -o trim                         -d 'Trim image edges'
complete -c mogrify -o type                         -d 'Image type [type]' -xa '(mogrify -list type)'
complete -c mogrify -o unique-colors                -d 'Discard all but one of any pixel color'
complete -c mogrify -o unsharp                      -d 'Sharpen the image [geometry]'
complete -c mogrify -o vignette                     -d 'Soften the edges of the image in vignette style [geometry]'
complete -c mogrify -o wave                         -d 'Alter an image along a sine wave [geometry]'
complete -c mogrify -o white-threshold              -d 'Force all pixels above the threshold into white [value]'
complete -c mogrify -o affinity                     -d 'Transform image colors to match this set of colors [filename]' -r
complete -c mogrify -o append                       -d 'Append an image sequence top to botto (use +append for left to right)'
complete -c mogrify -o clut                         -d 'Apply a color lookup table to the image'
complete -c mogrify -o coalesce                     -d 'Merge a sequence of images'
complete -c mogrify -o combine                      -d 'Combine a sequence of images'
complete -c mogrify -o composite                    -d 'Composite image '
complete -c mogrify -o crop                         -d 'Cut out a rectangular region of the image [geometry]'
complete -c mogrify -o deconstruct                  -d 'Break down an image sequence into constituent parts'
complete -c mogrify -o evaluate-sequence            -d 'Evaluate an arithmetic, relational, or logical expression [operator]'
complete -c mogrify -o fx                           -d 'Apply mathematical expression to an image channel(s) [expression]'
complete -c mogrify -o hald-clut                    -d 'Apply a Hald color lookup table to the image'
complete -c mogrify -o morph                        -d 'Morph an image sequence [value]'
complete -c mogrify -o mosaic                       -d 'Create a mosaic from an image sequence'
complete -c mogrify -o process                      -d 'Process the image with a custom image filter [arguments]' -xa '(mogrify -list filter)'
complete -c mogrify -o separate                     -d 'Separate an image channel into a grayscale image'
complete -c mogrify -o smush                        -d 'Smush an image sequence together [geometry]'
complete -c mogrify -o write                        -d 'Write images to this file [filename]' -r
complete -c mogrify -o delete                       -d 'Delete the image from the image sequence [indexes]'
complete -c mogrify -o duplicate                    -d 'Duplicate an image one or more times [count,indexes]'
complete -c mogrify -o insert                       -d 'Insert last image into the image sequence [index]'
complete -c mogrify -o swap                         -d 'Swap two images in the image sequence [indexes]'
complete -c mogrify -o debug                        -d 'Display copious debugging information [events]' -xa '(mogrify -list debug)'
complete -c mogrify -o log                          -d 'Format of debugging information [format]' -xa '(__fish_complete_convert_options format)'
complete -c mogrify -o list                         -d 'Print a list of supported option arguments [type]' -xa '(mogrify -list list)'
