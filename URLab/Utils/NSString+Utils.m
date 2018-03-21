//
//  NSString+Utils.m
//  URLab
//
//  Created by lin weiyan on 09/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (CGFloat)textWidth:(UIFont *)font width:(CGFloat)width
{
//      NSStringDrawingUsesFontLeading                  计算行高时使用行距。（字体大小+行间距=行距）
//      NSStringDrawingUsesLineFragmentOrigin           绘制文本时使用line fragement origin而不是baseline origin。
//      NSStringDrawingUsesDeviceMetrics                计算布局时使用图元字形（而不是印刷字体）。
    
    CGRect tmpRect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:[NSDictionary dictionaryWithObjectsAndKeys:font ,NSFontAttributeName, nil] context:nil];
    return tmpRect.size.height;
}


@end
