//
//  DrawContent.m
//  DrawContent
//
//  Created by Nikhil Gohil on 4/22/12.

#import "DrawContentView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

@implementation DrawContentView

@synthesize baseLayer = _baseLayer;
@synthesize pathLayer = _pathLayer;
@synthesize lineColor = _lineColor;
@synthesize lineSize = _lineSize;
@synthesize shapeName = _shapeName;
@synthesize fontTextName = _fontTextName;
@synthesize messageText = _messageText;
@synthesize fontTextSize = _fontTextSize;

@synthesize firstPoint = _firstPoint;
@synthesize secondPoint = _secondPoint;
@synthesize thirdPoint = _thirdPoint;
@synthesize fourthPoint = _fourthPoint;
@synthesize fifthPoint = _fifthPoint;
@synthesize sixthPoint = _sixthPoint;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		self.baseLayer = [CALayer layer];
		self.baseLayer.frame = CGRectMake(0.0f, 0.0f, 
											   CGRectGetWidth(self.layer.bounds), 
											   CGRectGetHeight(self.layer.bounds));
		[self.layer addSublayer:self.baseLayer];
		
		self.lineColor = [UIColor colorWithRed:34.0/255.0f green:139.0/255.0f blue:34.0/255.0f alpha:1];
		self.lineSize = 5.0f;
		self.fontTextName = @"GillSans-Light  ";
		self.messageText = @"";
		self.fontTextSize = 13.0f;
		//bezier points
		self.firstPoint = CGPointMake(0, 0);
		self.secondPoint = CGPointMake(0, 0);
		self.thirdPoint = CGPointMake(0, 0);
		self.fourthPoint = CGPointMake(0, 0);
		self.fifthPoint = CGPointMake(0, 0);
		
		[self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)startDrawingContent{	
	if ([self.messageText isKindOfClass:[NSString class]] && [self.messageText length] >1 ) {
		[self drawingText];
	}else if ([self.shapeName isKindOfClass:[NSString class]] && [self.shapeName length] >1) {
		[self drawingShapes];
	}else {
		[self drawingShapes];
	}

}

-(void)drawingText {
	[self drawTextWithText:self.messageText withFontSize:self.fontTextSize withFillColor:[UIColor clearColor] withLineColor:self.lineColor withLineWidth:self.lineSize];
}

-(void)drawingShapes {
	if ([self.shapeName isEqualToString:@"drawRight"]) {
		[self clearArea];
		[self drawWithBezierPath:[self rightBezierPath] withColor:self.lineColor withLineWidth:self.lineSize];
	}else if ([self.shapeName isEqualToString:@"drawCancel"]) {
		[self clearArea];
		[self drawWithBezierPath:[self crossBezierPath] withColor:self.lineColor withLineWidth:self.lineSize];
	}else if ([self.shapeName isEqualToString:@"drawPentagon"]) {
		[self clearArea];
		[self drawWithBezierPath:[self pentagonBezierPath] withColor:self.lineColor withLineWidth:self.lineSize];
	}else if ([self.shapeName isEqualToString:@"drawArc"]) {
		[self clearArea];
		[self drawWithBezierPath:[self arcBezierPath] withColor:self.lineColor withLineWidth:self.lineSize];
	}else if ([self.shapeName isEqualToString:@"drawCubicCurve"]) {
		[self clearArea];
		[self drawWithBezierPath:[self cubicCurveBezierPath] withColor:self.lineColor withLineWidth:self.lineSize];
	}else if ([self.shapeName isEqualToString:@"drawQuadCurve"]) {
		[self clearArea];
		[self drawWithBezierPath:[self quadCurveBezierPath] withColor:self.lineColor withLineWidth:self.lineSize];
	}else if ([self.shapeName isEqualToString:@"drawRawQuadCurve"]) {
		[self clearArea];
		[self drawWithBezierPath:[self quadCurveRawBezierPath] withColor:self.lineColor withLineWidth:self.lineSize];
	}else {
		[self clearArea];
		[self drawWithBezierPath:[self crossBezierPath] withColor:self.lineColor withLineWidth:self.lineSize];
	}

}

-(void)clearArea {
	if (self.pathLayer != nil) {
		[self.pathLayer removeFromSuperlayer];
        self.pathLayer = nil;
	}
}

-(void)drawWithBezierPath:(UIBezierPath*)path withColor:(UIColor*)pathColor withLineWidth:(CGFloat)lineSize {

	if (self.pathLayer != nil) {
		[self.pathLayer removeFromSuperlayer];
        self.pathLayer = nil;
	}
	CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.baseLayer.bounds;
	pathLayer.lineJoin = kCALineJoinRound;
	pathLayer.lineCap = kCALineCapSquare;
	pathLayer.strokeColor = [pathColor CGColor];
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
	[pathLayer setStrokeEnd:5.0f];
	[pathLayer setStrokeEnd:3.0f];
    pathLayer.fillColor =  nil;
    pathLayer.lineWidth = lineSize;
    
    [self.baseLayer addSublayer:pathLayer];
	
    self.pathLayer = pathLayer;
}

-(void)drawTextWithText:(NSString*)message withFontSize:(CGFloat)fontSize withFillColor:(UIColor*)fillColor withLineColor:(UIColor*)lineColor withLineWidth:(CGFloat)lineSize
{	
    if (self.pathLayer != nil) {
        [self.pathLayer removeFromSuperlayer];
        self.pathLayer = nil;
    }
    
    CGMutablePathRef letters = CGPathCreateMutable();
    CTFontRef font = CTFontCreateWithName((CFStringRef)self.fontTextName, fontSize, NULL); //GillSans-Light,Papyrus-Condensed,MarkerFelt-Thin,Baskerville-Italic

//    CTFontRef font = CTFontCreateWithName(CFSTR("GillSans-Light"), fontSize, NULL); //GillSans-Light,Papyrus-Condensed,MarkerFelt-Thin,Baskerville-Italic
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (id)font, kCTFontAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:message
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);	
	CFArrayRef runArray = CTLineGetGlyphRuns(line);
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++) 
        {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
                        {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(font);

    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.baseLayer.bounds;
    pathLayer.backgroundColor = [[UIColor clearColor] CGColor];
	pathLayer.bounds = CGPathGetPathBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.strokeColor = [lineColor CGColor];
    pathLayer.fillColor = fillColor.CGColor;
    pathLayer.lineWidth = lineSize;
    pathLayer.path = path.CGPath;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    [self.baseLayer addSublayer:pathLayer];
    
    self.pathLayer = pathLayer;
	
}

-(void)startAnimationWithDuration:(CGFloat)duration {
	
    [self.pathLayer removeAllAnimations];
	[self startDrawingContent];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
	pathAnimation.delegate = self;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
	
}
-(void) animationDidStart:(CAAnimation *)anim{

}


-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

}


-(UIBezierPath*)rightBezierPath{
	
	CGRect pathRect = CGRectInset(self.baseLayer.bounds, 2.0f, 2.0f);
    CGPoint centerLeft 	= CGPointMake(CGRectGetMinX(pathRect) + 3, CGRectGetMaxY(pathRect) / 3);
    CGPoint bottomCenter = CGPointMake((CGRectGetMaxX(pathRect) / 3) - 3,(CGRectGetMinY(pathRect) + 5));
	CGPoint rightCorner = CGPointMake(CGRectGetMaxX(pathRect) - 5,CGRectGetMaxY(pathRect) - 5);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:centerLeft];
    [path addLineToPoint:bottomCenter];
	[path addLineToPoint:rightCorner];
	
	return path;
}


-(UIBezierPath*)crossBezierPath{
	
	CGRect pathRect = CGRectInset(self.baseLayer.bounds, 0.0f, 0.0f);
	CGPoint topLeft = CGPointMake(CGRectGetMinX(pathRect) + (CGRectGetMaxX(pathRect)/100)*7,CGRectGetMaxY(pathRect) - (CGRectGetMaxY(pathRect)/100)*7);
    CGPoint bottomRight	= CGPointMake(CGRectGetMaxX(pathRect) - (CGRectGetMaxX(pathRect)/100)*7, CGRectGetMinY(pathRect) + (CGRectGetMaxY(pathRect)/100)*7);
	CGPoint bottomLeft	= CGPointMake(CGRectGetMinX(pathRect) + (CGRectGetMaxX(pathRect)/100)*6, CGRectGetMinY(pathRect) + (CGRectGetMaxY(pathRect)/100)*6);
	CGPoint topRight = CGPointMake(CGRectGetMaxX(pathRect) - (CGRectGetMaxX(pathRect)/100)*6,CGRectGetMaxY(pathRect) - (CGRectGetMaxY(pathRect)/100)*6);
	
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:topLeft];
    [path addLineToPoint:bottomRight];
	[path moveToPoint:bottomLeft];
	[path addLineToPoint:topRight];
	
	return path;
}


-(UIBezierPath*)pentagonBezierPath {
	CGRect pathRect = CGRectInset(self.baseLayer.bounds, 0.0f, 0.0f);
	CGPoint firstPoint = CGPointMake(CGRectGetMidX(pathRect), 0);
	CGPoint secondPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
	CGPoint thirdPoint = CGPointMake((CGRectGetMaxX(pathRect)/4)*3, CGRectGetMaxY(pathRect));
	CGPoint fourthPoint = CGPointMake((CGRectGetMaxX(pathRect)/4), CGRectGetMaxY(pathRect));
	CGPoint fifthPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
	UIBezierPath*    aPath = [UIBezierPath bezierPath];
	
	// Set the starting point of the shape.
	[aPath moveToPoint:firstPoint];
	
	// Draw the lines
	[aPath addLineToPoint:secondPoint];
	[aPath addLineToPoint:thirdPoint];
	[aPath addLineToPoint:fourthPoint];
	[aPath addLineToPoint:fifthPoint];
	[aPath closePath];
	
	return aPath;
}


- (UIBezierPath*)arcBezierPath
{
	CGRect pathRect = CGRectInset(self.baseLayer.bounds, 0.0f, 0.0f);

	UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect))
														 radius:CGRectGetMidX(pathRect)
													 startAngle:0
													   endAngle:(3.14159265359 * 90 / 180)
													  clockwise:YES];
	return aPath;
}


- (UIBezierPath*)cubicCurveBezierPath {

	CGRect pathRect = CGRectInset(self.baseLayer.bounds, 0.0f, 0.0f);
    CGPoint firstPoint = CGPointMake(CGRectGetMinX(pathRect) + (CGRectGetMaxX(pathRect)/100)*10, CGRectGetMinY(pathRect));
	CGPoint secondPoint = CGPointMake(CGRectGetMaxX(pathRect) - (CGRectGetMaxX(pathRect)/100)*20, CGRectGetMaxY(pathRect)/3);
	CGPoint thirdPoint = CGPointMake(CGRectGetMaxX(pathRect)/3, - CGRectGetMaxY(pathRect)/6);
	CGPoint fourthPoint = CGPointMake((CGRectGetMaxX(pathRect)/3) * 2, CGRectGetMaxY(pathRect)/2);
	UIBezierPath* path = [UIBezierPath bezierPath];
	[path moveToPoint:firstPoint];
	[path addCurveToPoint:secondPoint controlPoint1:thirdPoint controlPoint2:fourthPoint];
	return path;
}

- (UIBezierPath*)quadCurveBezierPath {
	CGRect pathRect = CGRectInset(self.baseLayer.bounds, 0.0f, 0.0f);
	if (self.firstPoint.x == 0 && self.firstPoint.y ==0) {
		self.firstPoint = CGPointMake(CGRectGetMinX(pathRect) + (CGRectGetMaxX(pathRect)/100 )*10, CGRectGetMinY(pathRect));	
	}
	if (self.secondPoint.x == 0 && self.secondPoint.y ==0) {
		self.secondPoint = CGPointMake(CGRectGetMaxX(pathRect) - (CGRectGetMaxX(pathRect)/100)*20, CGRectGetMinY(pathRect));	
	}
	if (self.thirdPoint.x == 0 && self.thirdPoint.y ==0) {
		self.thirdPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
	}
	UIBezierPath* path = [UIBezierPath bezierPath];
	[path moveToPoint:self.firstPoint];
	[path addQuadCurveToPoint:self.secondPoint controlPoint:self.thirdPoint];
	return path;
}

- (UIBezierPath*)quadCurveRawBezierPath {
	CGRect pathRect = CGRectInset(self.baseLayer.bounds, 0.0f, 0.0f);
	
	CGPoint firstPoint = CGPointMake(CGRectGetMinX(pathRect) + (CGRectGetMaxX(pathRect)/100)*20, CGRectGetMinY(pathRect));
	CGPoint secondPoint = CGPointMake(CGRectGetMaxX(pathRect) - (CGRectGetMaxX(pathRect)/100)*35, CGRectGetMaxY(pathRect) - (CGRectGetMaxY(pathRect)/100)*25);
	CGPoint thirdPoint = CGPointMake(CGRectGetMinX(pathRect) - (CGRectGetMaxX(pathRect)/100)*20, CGRectGetMaxY(pathRect) - (CGRectGetMaxY(pathRect)/100)*25);
	CGPoint fourthPoint = CGPointMake(CGRectGetMaxX(pathRect) - (CGRectGetMaxX(pathRect)/100)*20, CGRectGetMaxY(pathRect));
	CGPoint fifthPoint = CGPointMake(CGRectGetMinX(pathRect) + (CGRectGetMaxX(pathRect)/100)*35, CGRectGetMinY(pathRect) + (CGRectGetMaxY(pathRect)/100)*20);
	CGPoint sixthPoint = CGPointMake(CGRectGetMinX(pathRect) - (CGRectGetMaxX(pathRect)/100)*12, CGRectGetMaxY(pathRect) - (CGRectGetMaxY(pathRect)/100)*7);
	
	UIBezierPath* path = [UIBezierPath bezierPath];
	[path moveToPoint:firstPoint];
	[path addQuadCurveToPoint:secondPoint controlPoint:thirdPoint];
	[path addLineToPoint:fourthPoint];
	[path addQuadCurveToPoint:fifthPoint controlPoint:sixthPoint];
	[path addLineToPoint:firstPoint];
	return path;
}


- (void)dealloc {
	
	self.baseLayer = nil;
	self.pathLayer = nil;
	[super dealloc];
}


@end
