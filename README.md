## DrawContent ##

This is a custom view where you can draw shape or draw text with animation.

[Sample for splash screen] (http://vimeo.com/54602798 "SplashView") and [password check] (https://vimeo.com/54601584 "PasswordCheck")


![Screenshot] (http://nikhilgohil11.com/github/Screenshot.png)



## How to use ##
	#import "DrawContent.h"
	
For shape:

	DrawContentView *drawContent = [[DrawContentView alloc] initWithFrame:CGRectMake(x, y, width, height)];

	drawContent.shapeName = @"drawQuadCurve"; //available shapes (Right , Cancel, Pentagon, Arc, Cubic curve, Quad curve)

	drawContent.lineSize = 2.1f;

    drawContent.lineColor = [UIColor blackColor];

	[scrollWithPaging addSubview:drawContent];

    [drawContent startAnimationWithDuration:2.5f];

For text:

	DrawContentView *drawContent = [[DrawContentView alloc] initWithFrame:CGRectMake(x, y, width, height)];

	drawContent.lineSize = 2.1f;

	drawContent.messageText = @"raw engineering";

	drawContent.fontTextSize = 23.0f;

	drawContent.lineColor = [UIColor blackColor];

	[scrollWithPaging addSubview:drawContent3];

    [drawContent3 startAnimationWithDuration:2.5f];
    
    
## Lincense ##

   [MIT License] (http://raweng.mit-license.org/ "MIT License")
     
