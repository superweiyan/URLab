//
//  URLayoutTestViewController.m
//  URLab
//
//  Created by lin weiyan on 27/04/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URLayoutTestViewController.h"
#import "Masonry.h"
#import "NSArray+MASAdditions.h"

@interface URLayoutTestViewController ()

@property (nonatomic, strong) UIView    *leftView;
@property (nonatomic, strong) UIView    *rightView;
@property (nonatomic, strong) NSArray   *colorArray;

@property (nonatomic, strong) MASConstraint *topConstraint;
//@property (nonatomic, strong) MASConstraint *topConstraint1;

@end

@implementation URLayoutTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    
    self.leftView = [[UIView alloc] init];
    self.leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.leftView];
    
    self.colorArray = @[[UIColor redColor], [UIColor blueColor]];
    
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
//    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).mas_offset(100);
//        make.left.mas_equalTo(self.view).mas_offset(100);
//        make.size.mas_equalTo(CGSizeMake(100, 30));
//    }];
    
//    [self initScrollView];

//    [self.view setNeedsUpdateConstraints];
    
    [self case3];
}

- (void)case1
{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(5,5,5,5));
        make.edges.equalTo(self.view);
    }];
    
    UIView *container = [UIView new];
    container.layer.borderColor = [UIColor yellowColor].CGColor;
    container.layer.borderWidth = 1;
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    int count = 17;
    
    UIView *lastView = nil;
    
    for ( int i = 1 ; i <= count ; ++i )
    {
        UILabel *subv = [UILabel new];
        subv.numberOfLines = 0;
        subv.text = @"adfjajdfjadjfadjfafdadfadfjasdjfjasdfadsfasjdfadfasdfasdfasdfasdfadfasdfadsfadfadsfadf";
//        [subv setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [container addSubview:subv];
        
        subv.backgroundColor = [self.colorArray objectAtIndex:(i%2)];
        
        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(container);
//            make.height.mas_equalTo(@(40));
            
            if ( lastView ) {
                make.top.mas_equalTo(lastView.mas_bottom);
            } else {
                make.top.mas_equalTo(container.mas_top);
            }
        }];
        
        lastView = subv;
    }
    
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}

- (void)case2
{
    UILabel *v1 = [[UILabel alloc] init];
    v1.text = @"11111";
    v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:v1];
    
    UILabel *v2 = [[UILabel alloc] init];
    v2.text = @"22222";
    v2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:v2];
    
    v1.mas_key = @"v1";
    v2.mas_key = @"v2";
    
    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        self.topConstraint = make.leading.mas_equalTo(self.view.mas_leading);
//        make.trailing.mas_equalTo(v2.mas_leading);
        make.width.mas_equalTo(self.view).multipliedBy(0.5);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(200);
    }];
    
    [v2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view).multipliedBy(0.5);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(100);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.topConstraint uninstall];
        
        [UIView animateWithDuration:2 animations:^{
            [v1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.trailing.mas_equalTo(self.view);
            }];
            
            [self.view layoutIfNeeded];
        }];
        
        
//        [UIView animateWithDuration:2 animations:^{
//            [v1 mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.leading.mas_equalTo(self.view.mas_leading).mas_offset(self.view.frame.size.width * 0.5);
//            }];
//
//            [self.view layoutIfNeeded];
//        }];
        
//        [self.topConstraint uninstall];
//        [self.topConstraint1 uninstall];
        
//        [v1 mas_updateConstraints:^(MASConstraintMaker *make) {
//            //            make.trailing.mas_equalTo(self.view);
////            make.leading.mas_equalTo(v2.mas_trailing);
//            //                make.leading.mas_equalTo(v2.mas_trailing);
//
//        }];
        
//        [v2 mas_updateConstraints:^(MASConstraintMaker *make) {
////            make.leading.mas_equalTo(self.view);
//        }];
        
        
        
//        [v2 mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.leading.mas_equalTo(self.view);
//            make.trailing.mas_equalTo(v1.mas_leading);
//            //            make.trailing.mas_equalTo(v1.mas_leading);
//        }];

//        [UIView animateWithDuration:2 animations:^{
//            [v1 layoutIfNeeded];
//            [v2 layoutIfNeeded];
//        }];
    });
}

- (void)case3
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    
    NSMutableArray *testArray = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i++) {
        UIView * subView = [UIView new];
        subView.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0];
        [backView addSubview:subView];
        [testArray addObject:subView];
    }
    
    CGFloat space = 300 / (testArray.count + testArray.count + 1);
    [testArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:space leadSpacing:space tailSpacing:space];
    [testArray mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(backView.mas_centerY);
        make.height.mas_equalTo(@160);
    }];
    
//    [testArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:30 leadSpacing:20 tailSpacing:10];
//    [testArray mas_makeConstraints:^(MASConstraintMaker *make){
//        make.centerX.equalTo(backView.mas_centerX);
//        make.width.mas_equalTo(@150);
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
