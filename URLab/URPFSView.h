//
//  URPFSView.h
//  URLab
//
//  Created by lin weiyan on 09/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface URPFSView : UILabel

@property (nonatomic, strong) CADisplayLink     *displayLink;
@property (nonatomic, assign) CFTimeInterval    timestamp;
@property (nonatomic, assign) NSUInteger        scheduleTimes;

@end
