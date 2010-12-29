//
//  CustomScrollBarAppDelegate.h
//  CustomScrollBar
//
//  Created by Dmitry Stadnik on 12/29/10.
//  Copyright 2010 www.dimzzy.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomScrollBarViewController;

@interface CustomScrollBarAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CustomScrollBarViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CustomScrollBarViewController *viewController;

@end

