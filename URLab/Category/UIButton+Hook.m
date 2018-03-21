//
//  UIButton+Hook.m
//  URLab
//
//  Created by lin weiyan on 06/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "UIButton+Hook.h"
#import <objc/runtime.h>

@implementation UIButton (Hook)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL selAddTarget = @selector(addTarget:action:forControlEvents:);
        SEL selMyAddTaget = @selector(MyAddTarget:action:forControlEvents:);
        
        Method methodAddTaget = class_getInstanceMethod(self, selAddTarget);
        Method methodMyAddTaget = class_getInstanceMethod(self, selMyAddTaget);
        
        //将 methodB的实现 添加到系统方法中 也就是说 将 methodA方法指针添加成 方法methodB的  返回值表示是否添加成功
        BOOL isTargetAdd = class_addMethod(self, selAddTarget, method_getImplementation(methodMyAddTaget), method_getTypeEncoding(methodMyAddTaget));
        //添加成功了 说明 本类中不存在methodB 所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
        if (isTargetAdd) {
            class_replaceMethod(self, selMyAddTaget, method_getImplementation(methodAddTaget), method_getTypeEncoding(methodAddTaget));
            
        } else {
            //添加失败了 说明本类中 有methodB的实现，此时只需要将 methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(methodAddTaget, methodMyAddTaget);
        }
    });
}

- (void)MyAddTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        if (![target respondsToSelector:action]) {
            NSLog(@"");
        }
    }
    [self MyAddTarget:target action:action forControlEvents:controlEvents];
}

@end
