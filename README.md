# CatPalettes

-------
#### 8/21 - Notes on [734d45f 'going back to the "jumpy"'](https://github.com/spacedrabbit/CatPalettes/commit/734d45f1f8ad1ed7be75a7a42d0f85db8d9273d2) 

...animation. it looks less broken than the attempt at reloading following the animation block. Further, the table refresh should be obvious following the cell animation since both are executing on the main queue and thus in serial. But now that I think about it, the examples in my mind of apps that have this feature (the tap to expand) all do so in an instataneous manner. 


#### 8/22 - Notes on [6fa432e 'adds menu vc, changes color'](https://github.com/spacedrabbit/CatPalettes/commit/01d9ab0b0f587b0b4a52a3793ed2278e8c6d0dcb)

...theme, adds geobackground image, credits added to README. It was at this point I decided to refocus on the actual MVP instead of the nice animations I'd envisioned the app to have. So i removed a bunch of code related to the show/hiding of the floating '+' icon at the bottom of the palettes view controller. 

-------------------------
### Credits:

- Inspiration
 	- ["Weekly Inspiration for Designers #64" by Muzli via Medium](https://medium.muz.li/weekly-inspiration-for-designers-64-d4639d318376#.tohjuv29m)
	- [Original Design - Dribbble](https://dribbble.com/shots/2895893-Small-app-for-making-palettes-and-gradients)
	- [Designed by Alexander Zaytsev - Dribbble](https://dribbble.com/anwaltzzz)

- Image Assets
	- Geometric Background Image
		- [Link - Dribbble](https://dribbble.com/shots/1414523-Free-Polygon-Backgrounds-V1) by [Ahmed Abbas] (https://dribbble.com/Ahmedeabbas)
	- Icons
		- Palette: [Link - Noun Project](https://thenounproject.com/term/color-swatch/290654/) by [Sergey Demushkin](https://thenounproject.com/mockturtle/)
		- Plus Icon: [Link - Noun Project](https://thenounproject.com/term/add/25957/) by [Mr. Yunis] (https://thenounproject.com/mr.yunis/)

- Pods
	- [RESideMenu](https://github.com/romaonthego/RESideMenu) by [Roman Efimov](https://twitter.com/romaonthego)
	- [SnapKit](https://github.com/SnapKit/SnapKit) by [SnapKit](https://github.com/SnapKit/)
