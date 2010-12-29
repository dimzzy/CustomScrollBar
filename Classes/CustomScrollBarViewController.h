//
//  CustomScrollBarViewController.h
//  CustomScrollBar
//
//  Created by Dmitry Stadnik on 12/29/10.
//  Copyright 2010 www.dimzzy.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomScrollBar.h"

@interface CustomScrollBarViewController : UIViewController {
@private
	UITextView *_textView;
	CustomScrollBar *_scrollBar;
}

@property(nonatomic, retain) IBOutlet UITextView *textView;
@property(nonatomic, retain) IBOutlet CustomScrollBar *scrollBar;

@end
