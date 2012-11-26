## DrawContent ##

This is a custom view where you can draw shape or draw text with animation.

[Sample for splash screen] (https://vimeo.com/54274152 "SplashView")

![Screenshot] (https://github.com/nikhilgohil11/DrawContent/blob/master/screenshot.png)

## How to use ##
	
For shape:

	`DrawContentView *drawContent = [[DrawContentView alloc] initWithFrame:CGRectMake(x, y, width, height)];

	drawContent.shapeName = @"drawQuadCurve"; //available shapes (Right , Cancel, Pentagon, Arc, Cubic curve, Quad curve)

	drawContent.lineSize = 2.1f;

    drawContent.lineColor = [UIColor blackColor];

	[scrollWithPaging addSubview:drawContent];

    [drawContent startAnimationWithDuration:2.5f];`

For text:

	`DrawContentView *drawContent = [[DrawContentView alloc] initWithFrame:CGRectMake(x, y, width, height)];

	drawContent.lineSize = 2.1f;

	drawContent.messageText = @"raw engineering";

	drawContent.fontTextSize = 23.0f;

	drawContent.lineColor = [UIColor blackColor];

	[scrollWithPaging addSubview:drawContent3];

    [drawContent3 startAnimationWithDuration:2.5f];`