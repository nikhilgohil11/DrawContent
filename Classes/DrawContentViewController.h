//
//  DrawContentViewController.h
//  DrawContent
//
//  Created by Nikhil Gohil on 5/18/12.
//

#import <UIKit/UIKit.h>
@class DrawContentView;

@interface DrawContentViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollWithPaging;
	DrawContentView *drawContent, *drawContent1, *drawContent2, *drawContent3, *drawContent4, *drawContent5, *drawContent6, *drawContent7;
    DrawContentView *welcomeTo;
}
-(void)drawing;
@end

