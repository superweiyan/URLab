//
//  URImToolView.h
//  URLab
//
//  Created by lin weiyan on 08/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^sendTextCallback) (NSString *);

@interface URImToolView : UIView

@property (nonatomic, copy) sendTextCallback  sendBlock;

- (void)resignFirstResponder;

@end
