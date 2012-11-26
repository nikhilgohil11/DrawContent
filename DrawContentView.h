//
//  DrawContent.h
//  DrawContent
//
//  Created by Nikhil Gohil on 4/22/12.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DrawContentView : UIView {

	CALayer *_baseLayer;
	CAShapeLayer *_pathLayer;
	UIColor *_lineColor;
	CGFloat _lineSize;
	NSString *_shapeName;
	NSString *_fontTextName;
	NSString *_messageText;
	CGFloat _fontTextSize;
	
	// Bezier points
	CGPoint _firstPoint;
	CGPoint _secondPoint;
	CGPoint _thirdPoint;
	CGPoint _fourthPoint;
	CGPoint _fifthPoint;
	CGPoint _sixthPoint;
    
    //arc
    CGFloat _arcAngle;
    
}
@property (nonatomic, retain) CALayer *baseLayer;
@property (nonatomic, retain) CALayer *pathLayer;
@property (nonatomic, retain) UIColor *lineColor;
@property (assign) CGFloat lineSize;
@property (nonatomic, retain) NSString *shapeName;

@property (nonatomic, retain) NSString *fontTextName;
@property (nonatomic, retain) NSString *messageText;
@property (assign) CGFloat fontTextSize;

// Bezier path
@property (assign) CGPoint firstPoint;
@property (assign) CGPoint secondPoint;
@property (assign) CGPoint thirdPoint;
@property (assign) CGPoint fourthPoint;
@property (assign) CGPoint fifthPoint;
@property (assign) CGPoint sixthPoint;



-(void)drawWithBezierPath:(UIBezierPath*)path withColor:(UIColor*)pathColor withLineWidth:(CGFloat)lineSize;
-(void)drawTextWithText:(NSString*)message withFontSize:(CGFloat)fontSize withFillColor:(UIColor*)fillColor withLineColor:(UIColor*)lineColor withLineWidth:(CGFloat)lineSize;
-(void)startAnimationWithDuration:(CGFloat)duration;
-(void)clearArea;
-(void)startDrawingContent;
-(void)drawingText;
-(void)drawingShapes;
-(UIBezierPath*)quadCurveRawBezierPath;
-(UIBezierPath*)rightBezierPath;
-(UIBezierPath*)crossBezierPath;
-(UIBezierPath*)pentagonBezierPath;
-(UIBezierPath*)arcBezierPath;
-(UIBezierPath*)cubicCurveBezierPath;
-(UIBezierPath*)quadCurveBezierPath;
@end
