//
//  URBubbyLayer.m
//  URLab
//
//  Created by lin weiyan on 21/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URBubbyLayer.h"

@implementation URBubbyLayer

- (void)drawInContext:(CGContextRef)ctx
{
    UIBezierPath* ovalPath = [UIBezierPath bezierPath];
    
    CGPoint pointA = CGPointMake(0, self.bounds.size.height/2);
    CGPoint pointB = CGPointMake(self.bounds.size.width/2, 0);
    CGPoint pointC = CGPointMake(self.bounds.size.width, self.bounds.size.height/2);
    CGPoint pointD = CGPointMake(self.bounds.size.width/2, self.bounds.size.height);
    
    CGPoint c1 = CGPointMake(pointA.x + self.offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, pointB.y - self.offset);
    
    CGPoint c3 = CGPointMake(pointB.x, pointB.y + self.offset);
    CGPoint c4 = CGPointMake(pointC.x + self.offset, pointC.y);
    
    CGPoint c5 = CGPointMake(pointC.x - self.offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, pointD.y + self.offset);
    
    CGPoint c7 = CGPointMake(pointD.x, pointD.y - self.offset);
    CGPoint c8 = CGPointMake(pointA.x - self.offset, pointA.y);
    
    [ovalPath moveToPoint: pointA];
    [ovalPath addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [ovalPath addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [ovalPath addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [ovalPath addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    
    [ovalPath closePath];
    
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetFillColorWithColor(ctx, self.indicatorColor.CGColor);
    CGContextFillPath(ctx);

}

@end
