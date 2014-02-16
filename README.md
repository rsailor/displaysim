displaysim
==========

### The Summary
Buffered display simulation in Processing intended for conversion to AVR C.

### More Details
I needed to create a low level graphics library for a buffered screen. I used
Processing to simulate a screen with an additional buffer and wrote a set of
basic graphics functions using common algorithms. The code was written in such
a way that it may be easy to convert to embedded C for an AVR microcontroller.

### Usage
#### Parameters
There are three parameters at the top of the displaysim file.

**WIDTH** sets the simulated pixel width of the display window.

**HEIGHT** sets the simulated pixel height of the display window.

**SCALE** is the real pixel width and height of each simulated pixel. For
example, when SCALE is set to 2, each simulated pixel will be a 2 by 2
pixel block. The purpose of scale is to make small resolution displays
easier to see. 

#### Graphics Functions
The majority of the program, and quite frankly the main purpose of the program, 
are the primitive graphics functions. To make a clear distinction between
the displaysim functions and Processing's built-in graphics primitives, each
displaysim function has the prefix "q". It's arbitrary and does not require a
lot of extra typing.

##### Included Functions
Note that whenever "drawing" is mentioned, it is in reference to drawing to
the buffer, not the screen, unless specified explicitly.

**qPoint**    
Params - x, y, r, g, b  
Desc - Draws a single pixel at the specified coordinate with the specified
color. This is the base function all other displaysim graphics functions
are built on top of.

**qLine**  
Params - x0, y0, x1, y1, r, g, b  
Desc - Draws a line using the Bresenham line algorithm.

**qHLine**  
Not yet implemented

**qVLine**  
Not yet implemented

**qTriangle**  
Params - x0, y0, x1, y1, x2, y2, r, g, b  
Desc - Draws a triangle using the three coordinates as line endpoints.

**qTriangleSolid**  
Params - x0, y0, x1, y1, x2, y2, r, g, b  
Desc - Draws a filled rectangle by finding a bounding rectangle and then
filling the triangle using a half-space function. Currently, to match the
discrepency between the half-space and Bresenham algorithms, the
`qTriangle()` function is called at the end.

**qRect**  
Params - x0, y0, h, w, r, g, b   
Desc - Draws a rectangle by drawing four lines from the calculated
corner points.

**qRectSolid**  
Params - x0, y0, h, w, r, g, b  
Desc - Draws a filled rectangle via a scanline pattern.

**qCircle**

**qCircleSolid**

**qEllipse**

**qEllipseSolid**

**qBGFill**

**qText**

**qTextBox**

**qImage**  
Not yet implmented

**qRefresh**

**qClear**

#### Using the Library
The `setup()` and `draw()` functions are the executed code, which is
standard in Processing. `setup()` is run once, and then `draw()` is looped
repeatedly. There are some neccessary lines of code in the `setup()` function.
Anything under the "Run Commands" comment is fair game.

### Planned or Potential Updates
**Color representation**  
Instead of three parameters - r, g, and b - I might change this to a three
member struct. Either that, or have a fill and outline variable similar
to Processing that is updated and stored by a function.


### Extra Utility
**texttohex** is a utility for converting fonts into the bitmap format used in
displaysim. Without alteration, texttohex can import any font on your system.
You can check the available fonts using `printArray(PFont.list())`. The format
is one pixel per bit, packed in bytes. This packing takes a few extra steps to
interpret, but is critical for use in a microcontroller. For example, the full
ASCII alphabet in 12 pixel Consolas uses over 1 KByte of program memory. This
might not seem like a lot, but these 8-bit AVR chips have about 32 KB of
program memory and between 512 and 2048 bytes of non-volitile memory.
