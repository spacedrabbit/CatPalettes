# CatPalettes

-------
#### 8/21 - Notes on [734d45f 'going back to the "jumpy"'](https://github.com/spacedrabbit/CatPalettes/commit/734d45f1f8ad1ed7be75a7a42d0f85db8d9273d2) 

...animation. it looks less broken than the attempt at reloading following the animation block. Further, the table refresh should be obvious following the cell animation since both are executing on the main queue and thus in serial. But now that I think about it, the examples in my mind of apps that have this feature (the tap to expand) all do so in an instataneous manner. 


#### 8/22 - Notes on [6fa432e 'adds menu vc, changes color'](https://github.com/spacedrabbit/CatPalettes/commit/01d9ab0b0f587b0b4a52a3793ed2278e8c6d0dcb)

...theme, adds geobackground image, credits added to README. It was at this point I decided to refocus on the actual MVP instead of the nice animations I'd envisioned the app to have. So i removed a bunch of code related to the show/hiding of the floating '+' icon at the bottom of the palettes view controller. 


#### 8/24
#### 1. Notes on [aa4af64 'fixes dynamic class checking bug](https://github.com/spacedrabbit/CatPalettes/tree/aa4af648bdbcd0f9e1c120cc554d4de16eda4fb3)

..., adds comments. As suspected, the type check I was doing wasn't properly determining the value of the nav controller's top VC. I had to modify it so that there was a run time check on the classes via their `.dynamicType`. Following this, the checks worked properly and I was no longer pushing the same VC onto the navigation stack when returning from the menu. Though, a fortunate side effect of this issue was discovering a (non-block based!) cyclical retain cycle in the pod I was using...

#### 2. Notes on [c0d0ad9 - 'starts to update flow from...'](https://github.com/spacedrabbit/CatPalettes/tree/c0d0ad9f7499641641d882945c0d816972012270) & [4499296 - 'because the library doesn't actually...](https://github.com/spacedrabbit/CatPalettes/tree/4499296fdf9dc14097dd0c1056a71c4dc4d87e97)

... I noticed that the app's memory footprint increased by ~1MiB each time I pushed the VC containing a color picker view (from SwiftHSVColorPicker). I thought it was odd that Instruments wasn't detecting a leak or retain cycle, considering how perfectly reproducible the issue was. The best I could gather was that each generation I was marking in Instruments was detecting a new ~1MiB allocation from a call to `CFData`

After looking at the pod, the problem quickly became apparent. It appears that the pod makes an attempt to use a delegate-protocl pattern for informing when a user has selected a new color on the color wheel. However, no actual protocol is defined. Rather, the `ColorWheel` class has an instance variable [`var delegate: SwiftHSVColorPicker`](https://github.com/johankasperi/SwiftHSVColorPicker/blob/1.0.9/Source/ColorWheel.swift#L30), and the `SwiftHSVColorPicker` class in turn has a strong reference back to its [`ColorWheel`](https://github.com/johankasperi/SwiftHSVColorPicker/blob/1.0.9/Source/SwiftHSVColorPicker.swift#L11).

There is no [issue](https://github.com/johankasperi/SwiftHSVColorPicker/issues) currently tracking this problem, so I have planned to submit a proposed fix shortly for the pod. However, I have already patched the issue in my own project. 


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
		- Minus Icon: [Link - Nount Project](https://thenounproject.com/search/?q=minus&i=18952) by [Icomatic](https://thenounproject.com/Icomatic/)

- Pods
	- [RESideMenu](https://github.com/romaonthego/RESideMenu) by [Roman Efimov](https://twitter.com/romaonthego)
	- [SnapKit](https://github.com/SnapKit/SnapKit) by [SnapKit](https://github.com/SnapKit/)
