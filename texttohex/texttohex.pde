// Text to Hex Converter //
/*
Author: Ryan Sailor
Website: http://ryansailor.com

This utility will convert fonts
into character bitmaps. See console for output.

See printArray(PFont.list()) for available fonts.

NOTE: Please use a monospace font. Otherwise the kerning
will be off. Poor kerning makes everyone sad.
*/

// Parameters

// Character size
int charSize = 12;

// Program will store characters with this pixel width
// including whitespace on side. You need to manually
// set this for each font face and size
int charWidth = 7;

// Font Face
String fontFace = "Consolas";

void setup() {
    
    // Screen Setup
    size(charWidth,charSize);
    background(255);
    fill(0);
    
    // Text Setup
    PFont font;
    font = createFont(fontFace,charSize,false);
    textFont(font);
    textAlign(LEFT, TOP);
    
    // Run Program
    String characters = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
    StringList hexValues = new StringList();
    int singleHex = 0;
    int bitCount = 0;
    
    for(int i = 0; i < characters.length(); i++) {
        background(255);
        text(characters.charAt(i),0,0);
        loadPixels();
        for(int j = 0; j < pixels.length; j++) {
            color pixel = pixels[j];
            singleHex = singleHex << 1;
            if((pixel & 0xFFFFFF) < 0xFFFFFF) {
                singleHex++;           
            }
            bitCount++;
            
            // When singleHex is full, add to hexValues
            if(bitCount == 8) {
                hexValues.append("0x" + hex(singleHex,2));
                singleHex = 0;
                bitCount = 0;
            }
        }
        // if bitCount is not 0, then there are some extra bits added
        // we push the bits to the big end
        if(bitCount != 0) {
            singleHex = singleHex << (8-bitCount);   
            hexValues.append("0x" + hex(singleHex,2));
            singleHex = 0;
            bitCount = 0;        
        }
        updatePixels();
    }
    
    // Output results
    for(int i = 0; i < hexValues.size(); i++) {
        print(hexValues.get(i));
        if(i < hexValues.size()-1)
            print(",");
    }
    
}

void draw() {
    
}
