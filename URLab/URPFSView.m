//
//  URPFSView.m
//  URLab
//
//  Created by lin weiyan on 09/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URPFSView.h"

@implementation URPFSView

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
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTicks:)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//        [_displayLink setPaused:YES];
    }
    return self;
}

- (void)linkTicks:(CADisplayLink *)link
{
    _scheduleTimes ++;
    
    //當前時間戳
    if(_timestamp == 0){
        _timestamp = link.timestamp;
    }
    
    CFTimeInterval timePassed = link.timestamp - _timestamp;
    
    if(timePassed >= 1.f) {
        //fps
        CGFloat fps = _scheduleTimes/timePassed;
        _timestamp = link.timestamp;
        _scheduleTimes = 0;
        self.text = @(fps).stringValue;
    }
}

@end
