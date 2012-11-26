//
//  DrawContentAppDelegate.h
//  DrawContent
//
//  Created by Nikhil Gohil on 5/18/12.
//

#import <UIKit/UIKit.h>

@class DrawContentViewController;

@interface DrawContentAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DrawContentViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DrawContentViewController *viewController;

@end

