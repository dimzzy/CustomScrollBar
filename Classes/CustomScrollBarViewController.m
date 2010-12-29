//
//  CustomScrollBarViewController.m
//  CustomScrollBar
//
//  Created by Dmitry Stadnik on 12/29/10.
//  Copyright 2010 www.dimzzy.com. All rights reserved.
//

#import "CustomScrollBarViewController.h"

@implementation CustomScrollBarViewController

@synthesize textView = _textView;
@synthesize scrollBar = _scrollBar;

- (void)dealloc {
	self.textView = nil;
	self.scrollBar = nil;
    [super dealloc];
}

@end
