//
//  CustomScrollBar.m
//  CustomScrollBar
//
//  Created by Dmitry Stadnik on 12/29/10.
//  Copyright 2010 www.dimzzy.com. All rights reserved.
//

#import "CustomScrollBar.h"

@interface CustomScrollBar (Private)

@property(nonatomic, readonly) NSUInteger thumbHeight;

- (void)updateContentSize;
- (void)updateContentOffset;
- (void)updateSourceContentOffset;
- (void)updateThumbImagePosition;

@end


@implementation CustomScrollBar

- (void)setupView {
	_thumbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thumb.png"]];
	_thumbImageView.contentMode = UIViewContentModeCenter;
	[self addSubview:_thumbImageView];
	_thumbScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
	_thumbScrollView.bounces = NO;
	_thumbScrollView.decelerationRate = 0;
	_thumbScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
	_thumbScrollView.showsHorizontalScrollIndicator = NO;
	_thumbScrollView.showsVerticalScrollIndicator = NO;
	_thumbScrollView.delegate = self;
	_thumbScrollView.backgroundColor = [UIColor clearColor];
	[self addSubview:_thumbScrollView];
	[self updateContentSize];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self setupView];
    }
    return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[self setupView];
}

- (void)dealloc {
	[_thumbImageView release];
	[_thumbScrollView release];
	if (_scrollView) {
		_scrollView.delegate = nil;
		[_scrollView release];
	}
    [super dealloc];
}

- (UIScrollView *)scrollView {
	return _scrollView;
}

- (void)setScrollView:(UIScrollView *)scrollView {
	if (_scrollView == scrollView) {
		return;
	}
	if (_scrollView) {
		if (_scrollView.delegate == self) {
			_scrollView.delegate = nil;
		}
		[_scrollView release];
	}
	_scrollView = [scrollView retain];
	if (_scrollView) {
		_scrollView.delegate = self;
	}
	[self updateContentSize];
}

- (void)layoutSubviews {
	_thumbScrollView.frame = self.bounds;
	[self updateContentSize];
	[self updateContentOffset];
	_thumbImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.thumbHeight);
	[self updateThumbImagePosition];
}

- (NSUInteger)thumbHeight {
	return _thumbImageView.image.size.height;
}

- (void)updateContentSize {
	CGFloat contentHeight;
	if (self.scrollView) {
		//contentHeight = self.scrollView.contentSize.height * (self.bounds.size.height / self.scrollView.bounds.size.height);
		contentHeight = self.bounds.size.height + self.bounds.size.height - self.thumbHeight;
	} else {
		contentHeight = self.bounds.size.height;
	}
	_thumbScrollView.contentSize = CGSizeMake(self.bounds.size.width, roundf(contentHeight));
}

- (void)updateContentOffset {
	CGFloat targetHeight = _thumbScrollView.contentSize.height - _thumbScrollView.bounds.size.height;
	if (targetHeight < 0) {
		targetHeight = 0;
	}
	CGFloat sourceHeight = self.scrollView.contentSize.height - self.scrollView.bounds.size.height;
	if (sourceHeight < 0) {
		sourceHeight = 0;
	}
	CGFloat contentY = 0;
	if (targetHeight > 0 && sourceHeight > 0) {
		CGFloat ry = self.scrollView.contentOffset.y / sourceHeight;
		if (ry < 0) {
			ry = 0;
		} else if (ry > 1) {
			ry = 1;
		}
		contentY = (1 - ry) * targetHeight;
	}
	if (contentY != _thumbScrollView.contentOffset.y) {
		_thumbContentOffsetUpdatesCount++;
		_thumbScrollView.contentOffset = CGPointMake(0, contentY);
	}
}

- (void)updateSourceContentOffset {
	CGFloat targetHeight = _thumbScrollView.contentSize.height - _thumbScrollView.bounds.size.height;
	if (targetHeight < 0) {
		targetHeight = 0;
	}
	CGFloat sourceHeight = self.scrollView.contentSize.height - self.scrollView.bounds.size.height;
	if (sourceHeight < 0) {
		sourceHeight = 0;
	}
	CGFloat contentY = 0;
	if (targetHeight > 0 && sourceHeight > 0) {
		CGFloat ry = _thumbScrollView.contentOffset.y / targetHeight;
		contentY = (1 - ry) * sourceHeight;
	}
	if (contentY != self.scrollView.contentOffset.y) {
		_sourceContentOffsetUpdatesCount++;
		self.scrollView.contentOffset = CGPointMake(0, contentY);
	}
}

- (void)updateThumbImagePosition {
	CGFloat targetHeight = _thumbScrollView.bounds.size.height - self.thumbHeight;
	if (targetHeight < 0) {
		targetHeight = 0;
	}
	CGFloat sourceHeight = self.scrollView.contentSize.height - self.scrollView.bounds.size.height;
	if (sourceHeight < 0) {
		sourceHeight = 0;
	}
	CGFloat thumbY = 0;
	if (targetHeight > 0 && sourceHeight > 0) {
		CGFloat ry = self.scrollView.contentOffset.y / sourceHeight;
		if (ry < 0) {
			ry = 0;
		} else if (ry > 1) {
			ry = 1;
		}
		thumbY = ry * targetHeight;
	}
	CGRect r = _thumbImageView.frame;
	r.origin.y = roundf(thumbY);
	_thumbImageView.frame = r;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (self.scrollView == scrollView) {
		if (_sourceContentOffsetUpdatesCount > 0) {
			_sourceContentOffsetUpdatesCount--;
			return;
		}
		[self updateContentOffset];
		[self updateThumbImagePosition];
	} else if (_thumbScrollView == scrollView) {
		if (_thumbContentOffsetUpdatesCount > 0) {
			_thumbContentOffsetUpdatesCount--;
			return;
		}
		[self updateSourceContentOffset];
		[self updateThumbImagePosition];
	}
}

- (void)scrollViewContentDidChange {
	[self updateContentSize];
	[self updateContentOffset];
	[self updateThumbImagePosition];
}

@end
