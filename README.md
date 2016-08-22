# CatPalettes

8/21 - Notes on 734d45f 'going back to the "jumpy"'

...animation. it looks less broken than the attempt at reloading following the animation block. Further, the table refresh should be obvious following the cell animation since both are executing on the main queue and thus in serial. But now that I think about it, the examples in my mind of apps that have this feature (the tap to expand) all do so in an instataneous manner. 


8/22 - Notes on 6fa432e 'adds menu vc, changes color'

...theme, adds geobackground image, credits added to README. It was at this point I decided to refocus on the actual MVP instead of the nice animations I'd envisioned the app to have. So i removed a bunch of code related to the show/hiding of the floating '+' icon at the bottom of the palettes view controller. 

-------------------------
### Credits:

- Image Assets
	- Geometric Background Image
		- https://dribbble.com/shots/1414523-Free-Polygon-Backgrounds-V1 by Ahmed Abbas (https://dribbble.com/Ahmedeabbas)
	- Icons
		- Palette: 
		- Plus Icon: https://thenounproject.com/term/add/25957/ by Mr. Yunis (https://thenounproject.com/mr.yunis/)

- Pods
	- RESideMenu: https://github.com/romaonthego/RESideMenu by Roman Efimov (https://twitter.com/romaonthego)
	- SnapKit: https://github.com/SnapKit/SnapKit