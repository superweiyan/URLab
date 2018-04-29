//
//  MFBannerView.m
//  URLab
//
//  Created by lin weiyan on 31/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "MFBannerView.h"

@interface MFBannerView()

@property (nonatomic, strong) NSArray               *viewArrays;
@property (nonatomic, strong) UIScrollView          *viewScrollView;

@end

@implementation MFBannerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initViews];
    }
    return self;
}

- (void)initData
{
    self.viewArrays = @[@(1), @(2), @(3), @(4), @(5), @(6)];
}

- (UIColor *)getColor:(int)i
{
    if (i % 2 == 0) {
        return [UIColor redColor];
    }
    return [UIColor blueColor];
}

- (void)initViews
{
    self.viewScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.viewScrollView.bounces = NO;
    self.viewScrollView.pagingEnabled = YES;
    
    CGFloat w = (self.viewArrays.count - 1) * 80 + 100;
    self.viewScrollView.contentSize = CGSizeMake(w, 100);
    
    [self addSubview:self.viewScrollView];
    
    CGFloat x = 0;
    
    for (int i = 0; i < _viewArrays.count; i++) {
        UIView *vw = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 100, 80)];
        vw.backgroundColor = [self getColor:i];
        [self.viewScrollView addSubview:vw];
        x += 100;
    }
}

@end
