# Extra!

Extra INFORMATION, Extra SATURATION, Extra NOISE

## Idea
> Marketing is the language of news media, not information.

The idea was born as a reflection on the state of news media. The focus on information was lost in favor of clickbaiting. Views and revenue rate much higher in their scale of importance than public knowledge. This was seen in the 2016 election, where the media gave Trump an overwhelming amount of attention due to the views he generated. Advertisement, the entertainment industry, sports, etc. We're flooded by a constant stream of shallow

To generate this reflection, we overlapped a newspaper, the physical medium of information, with video projections of different topics, representing the digital contemporary medium.



## Software
The software

### Processing + Syphon

One of the first problems we encountered was loading the video files. Turns out you cannot  load videos from a parent folder (ex: `"../media/filename.mp4"`), they can only be loaded from `"data/filename.mp4"`. Also, the data folder does not have to be written on the code. The correct line of code is: `Movie mov = new Movie(this, "filename.mp4")`.


Drawing the background on each of the canvases would draw over the other displayed images, so we needed them to be transparent. For this, the [`clear()` function](https://forum.processing.org/one/topic/pgraphics-transparency.html) works perfectly.


## Fabrication


## Interaction


## Putting it together
