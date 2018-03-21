//
//  URTextTableViewCell.m
//  URLab
//
//  Created by lin weiyan on 09/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URTextTableViewCell.h"
//#import ""

@interface URTextTableViewCell()

@property (nonatomic, strong) UITextView   *textView;

@end

@implementation URTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textView = [[UITextView alloc] init];
        self.textView.textContainer.lineFragmentPadding = 0;
        self.textView.textContainerInset = UIEdgeInsetsZero;
        self.textView.font = [UIFont systemFontOfSize:17];
        self.textView.backgroundColor = [UIColor redColor];
        [self addSubview:self.textView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    self.textView.frame = CGRectMake(size.width - 100 - 10, 5, 100, size.height - 10);
}

- (void)updateInfo:(NSString *)data
{
    self.textView.text = data;
}

@end
