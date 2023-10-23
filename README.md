# Custom Write Tool Fonts
Upgrade the Write Tool with the ability to use fonts you created yourself.

Requires the [Write Tool for Aseprite](https://github.com/JahdahThelen/Write-Tool-for-Aseprite) to work.

## How to use

### Install instructions

If you haven't already done this, follow the steps below to add the Add Font script to Aseprite.

1. Extract the ZIP file
1. Open Aseprite
1. Go to **File → Scripts → Open Scripts Folder**
1. Place the extracted files into the opened directory
1. Restart Aseprite
1. Open the tool under **File → Scripts → Add Font**
  
### Create the font

In this step you'll create all the characters you want to have in your font. You don't need to add all supported characters, as you can later specify which characters are included in your font. The following characters are currently supported:

>  abcdefghijklmnopqrstuvwxyz  
ABCDEFGHIJKLMNOPQRSTUVWXYZ  
 1234567890  
`~!@#$%^&*()-=_+[];'\{}:"|,./<>?

1. Create your own awesome font in Aseprite
1. Format the image like the following (also see Example.ase file)
    1. Color of the characters: #2d2d30
    1. Have a single layer for all characters
    1. Place each character on the height it should be written at 
   
### Create font LUA file

The LUA file contains all the information about your custom font. Some information will come from the .ase file you created in the previous step. See Available setting for more information on all font settings.

1. Have your fonts .ase file open in Aseprite
1. Start the **Add Font** script
1. Enter all font settings and click **Add Font**
1. Find your "Font Name".lua file in your **Documents** folder
1. Open Aseprite
1. Go to **File → Scripts → Open Scripts Folder**
1. Open the **Fonts** folder of the **Write Tool**
1. Place the font file into the opened directory

### Add the font to the Write Tool

Even though the LUA file has been placed among the other fonts, the Write Tool itself does not know the new font exists. Some information needs to be added to the LUA file of the Write Tool to be able to select it in the font dropdown.

1. Open Aseprite
1. Go to **File → Scripts → Open Scripts Folder**
1. Open the **Fonts** folder and edit the **fonts.lua** file
1. Add the filename of the newly created font to the list of files (don't forget the comma)

Congratulations!  

Now you can use your custom font in the Write Tool.

## Available Settings

### Font name
This name will be displayed in the Write Tools font selection.  
It also defines the filename of the font file.

### Layer
This selector contains the layers of your sprite. Select the layer in which your font is.

### Characters
Here you define all characters your font supports. The characters have to be placed in the same order as in the sprite to let the tool know which character is which (it didn't learn to read yet).  

This tool supports the following characters: 

> ABCDEFGHIJKLMNOPQRSTUVWXYZ  
abcdefghijklmnopqrstuvwxyz  
1234567890  
`~!@#$^&*()-_=+[]'\{}"|;:,.?/<>

### Characters with spaces
Some characters might have a space (vertical line of empty pixels) between their pixels. Add those characters here, to let the tool know that this is a single character and not two separate.

### Character spacing
This settings defines the amount of pixels the Write Tool should place between each character when you write a word.

### Line spacing
As the Write Tool supports multi-line texts, it has to know how many pixels those lines should be apart.

### Space width
I suppose the space is not a character you've drawn in your sprite, because it has no pixels. Here, you define how many pixels a space is. When this setting has the same value as the character spacing, the Write Tool will write all words without spaces.