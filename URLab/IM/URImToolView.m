//
//  URImToolView.m
//  URLab
//
//  Created by lin weiyan on 08/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URImToolView.h"

@interface URImToolView()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField       *inputView;
@property (nonatomic, assign) NSUInteger        autoAdd;

@end

@implementation URImToolView

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
        self.inputView = [[UITextField alloc] initWithFrame:self.bounds];
        self.inputView.delegate = self;
        self.inputView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.inputView];
        
        self.autoAdd = 0;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.inputView.frame = self.bounds;
}

- (void)resignFirstResponder
{
    [self.inputView resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *txt = [NSString stringWithFormat:@"%@+%ld", textField.text, self.autoAdd];
    self.autoAdd += 1;
    textField.text = @"";
    
    if (self.sendBlock) {
        self.sendBlock(txt);
    }
    return NO;
}

@end
