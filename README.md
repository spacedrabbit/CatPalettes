# CatPalettes

8/21 - Notes on 734d45f 'going back to the "jumpy"'

...animation. it looks less broken than the attempt at reloading following the animation block. Further, the table refresh should be obvious following the cell animation since both are executing on the main queue and thus in serial. But now that I think about it, the examples in my mind of apps that have this feature (the tap to expand) all do so in an instataneous manner. 