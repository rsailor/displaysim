displaysim
==========

### The Summary
Buffered display simulation in Processing intended for conversion to AVR C.

### More Details
I needed to create a low level graphics library for a buffered screen. I used
Processing to simulate a screen with an additional buffer and wrote a set of
basic graphics functions using common algorithms. The code was written in such
a way that it may be easy to convert to embedded C for an AVR microcontroller.

### Utility
**texttohex** is a utility for converting fonts into the bitmap format used in
displaysim. Without alteration, texttohex can import any font on your system.
You can check the available fonts using `printArray(PFont.list())`. The format
is one pixel per bit, packed in bytes. This packing takes a few extra steps to
interpret, but is critical for use in a microcontroller. For example, the full
ASCII alphabet in 12 pixel Consolas uses over 1 KByte of program memory. This
might not seem like a lot, but these 8-bit AVR chips have about 32 KB of
program memory and between 512 and 2048 bytes of non-volitile memory.
