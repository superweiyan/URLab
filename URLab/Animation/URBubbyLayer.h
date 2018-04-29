//
//  URBubbyLayer.h
//  URLab
//
//  Created by lin weiyan on 21/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIkit/UIKit.h>

@interface URBubbyLayer : CALayer

@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) UIColor *indicatorColor;

@end
