//
//  UIViewController+PushView.m
//  URLab
//
//  Created by lin weiyan on 21/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "UIViewController+PushView.h"

@implementation UIViewController (PushView)

- (void)pushView:(NSString *)name
{
    Class cls = NSClassFromString(name);
    UIViewController *vc = [[cls alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
