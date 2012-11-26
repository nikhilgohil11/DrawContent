//
//  DrawContentViewController.m
//  DrawContent
//
//  Created by Nikhil Gohil on 5/18/12.
//

#import "DrawContentViewController.h"
#import "DrawContentView.h"

@implementation DrawContentViewController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	[self.view setBackgroundColor:[UIColor whiteColor]];
    
    scrollWithPaging = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,320.0, self.view.frame.size.height)];
    [scrollWithPaging setContentSize:CGSizeMake(2240, self.view.frame.size.height)];
    [scrollWithPaging setDelegate:self];
    [scrollWithPaging setPagingEnabled:TRUE];
    [self.view addSubview:scrollWithPaging];
    
	[self drawing];
}

-(void)drawing{
	
	drawContent = [[DrawContentView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y - 20,self.view.frame.size.width +30,self.view.frame.size.width)];
	drawContent.shapeName = @"drawQuadCurve";
	drawContent.lineSize = 2.1f;
    drawContent.lineColor = [UIColor blackColor];
	[scrollWithPaging addSubview:drawContent];
	
	drawContent1 = [[DrawContentView alloc] initWithFrame:CGRectMake(320,self.view.frame.origin.y + 10,200,200)];
	drawContent1.shapeName = @"drawRight";
	drawContent1.lineSize = 10.0f;
	drawContent1.lineColor = [UIColor blackColor];
	[scrollWithPaging addSubview:drawContent1];

	drawContent2 = [[DrawContentView alloc] initWithFrame:CGRectMake(640,self.view.frame.origin.y + 40,self.view.frame.size.width +30,self.view.frame.size.width)];
	drawContent2.shapeName = @"drawPentagon";
	drawContent2.lineSize = 2.1f;
	drawContent2.fontTextSize = 23.0f;
	drawContent2.firstPoint = CGPointMake(10, 10);
    drawContent2.lineColor = [UIColor blackColor];
	[scrollWithPaging addSubview:drawContent2];
    
	drawContent3 = [[DrawContentView alloc] initWithFrame:CGRectMake(960 + 25,self.view.frame.origin.y + 80,self.view.frame.size.width,self.view.frame.size.width - 100)];
	drawContent3.lineSize = 2.1f;
	drawContent3.messageText = @"raw engineering";
	drawContent3.fontTextSize = 23.0f;
	drawContent3.lineColor = [UIColor blackColor];
	[scrollWithPaging addSubview:drawContent3];
	
	drawContent4 = [[DrawContentView alloc] initWithFrame:CGRectMake(960 + 50,170,50,50)];
	drawContent4.lineSize = 4.5f;
	drawContent4.shapeName = @"drawRawQuadCurve";
	drawContent4.lineColor = [UIColor blackColor];
	[scrollWithPaging addSubview:drawContent4];
    
	drawContent5 = [[DrawContentView alloc] initWithFrame:CGRectMake(1280,10,self.view.frame.size.width,self.view.frame.size.width)];
	drawContent5.lineSize = 4.5f;
	drawContent5.shapeName = @"drawCancel";
	drawContent5.lineColor = [UIColor blackColor];
	[scrollWithPaging addSubview:drawContent5];
    
    drawContent6 = [[DrawContentView alloc] initWithFrame:CGRectMake(1620,10,280,280)];
	drawContent6.lineSize = 4.5f;
	drawContent6.shapeName = @"drawArc";
	drawContent6.lineColor = [UIColor blackColor];
	[scrollWithPaging addSubview:drawContent6];
    
    drawContent7 = [[DrawContentView alloc] initWithFrame:CGRectMake(1920,10,self.view.frame.size.width,self.view.frame.size.width)];
	drawContent7.lineSize = 4.5f;
	drawContent7.shapeName = @"drawCubicCurve";
	drawContent7.lineColor = [UIColor blackColor];
	[scrollWithPaging addSubview:drawContent7];

    [self replay:0];    
}

-(void)replay:(int)currentPage{
    switch (currentPage) {
        case 0:
            [drawContent startAnimationWithDuration:2.5f];
            break;
        case 1:
            [drawContent1 startAnimationWithDuration:2.5f];
            break;
        case 2:
            [drawContent2 startAnimationWithDuration:2.5f];
            break;
        case 3:
            [drawContent3 startAnimationWithDuration:2.5f];
            [drawContent4 startAnimationWithDuration:2.5f];
            break;
        case 4:
            [drawContent5 startAnimationWithDuration:2.5f];
            break;
        case 5:
            [drawContent6 startAnimationWithDuration:2.5f];
            break;
        case 6:
            [drawContent7 startAnimationWithDuration:2.5f];
            break;
        default:
            break;

    }

}

#pragma -mark scrollview delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self replay:page];
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[drawContent release];
	[drawContent1 release];
	[drawContent2 release];
	[drawContent3 release];
	[drawContent4 release];
    [super dealloc];
}

@end
