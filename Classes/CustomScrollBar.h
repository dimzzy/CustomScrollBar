//
//  CustomScrollBar.h
//  CustomScrollBar
//
//  Created by Dmitry Stadnik on 12/29/10.
//  Copyright 2010 www.dimzzy.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomScrollBar : UIView <UIScrollViewDelegate> {
@private
	UIImageView *_thumbImageView;
	UIScrollView *_thumbScrollView;
	UIScrollView *_scrollView;
	NSUInteger _sourceContentOffsetUpdatesCount;
	NSUInteger _thumbContentOffsetUpdatesCount;
}

@property(nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (void)scrollViewContentDidChange;

@end
