# Swift 3.0 Drum Sequencer with Apple Watch Integration

Drum Sequencer App written in Swift 3.0 for a final year project. The application supports a dual-interface communication
between an iPhone & an Apple Watch. 

## iPhone Application User Manual

#### Instrument Selection: 
A PickerView that allows for selection of the instrument to edit. Upon selection, the currently configured
play sequence will be loaded to the grid interface.

#### Grid: 
A 4x4 collection of buttons representing the sequencer's steps. Reads from top left to bottom right.

#### Play Button: 
Toggles between Play / Pause state.

#### Save Button: 
Pressing the Save button will save the sequence playback of all instruments.

#### Load Button: 
Pressing the Load button will load the saved sequence playback of all instruments.

#### Tempo Slider: 
A variable slider ranging from 75 - 180 BPM, tempo change will be applied once the slider is released.


#### Reset Button:
Pressing the Reset button will erase the configured sequence playback of all instruments.


## Watch Application User Manual

#### Instrument Toggle:
A 2x3 grid of buttons, representing the 6 available instruments. Upon press, the selected instrument will toggle on / off.

#### High Pass Filter:
A slider represents the current cutoff frequency of the high pass filter. The setting can be changed either by pressing the 
symbols on the slider, or by scrolling with the physical watch crown. Ranges from 0 - 10000 Hz.

#### Equalizer:
The sliders that represent the boost levels of the Bass / Mid / Treble frequencies. Ranges from 0 - 10 gain.

#### Reverb:
PickerView represents the available room options for Reverb settings, controlled by the physical watch crown. The slider below
controls the dry/wet mix. Ranges from 0.0 - 1.0

