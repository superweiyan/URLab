//
//  URAnimationViewController.m
//  URLab
//
//  Created by lin weiyan on 02/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URAnimationViewController.h"

@interface URAnimationViewController ()

@property (nonatomic, strong) UIButton  *playBtn;
@property (nonatomic, strong) UIView    *animationView;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;


@end

@implementation URAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.height = [UIScreen mainScreen].bounds.size.height;
    
    self.playBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.width - 100)/2, self.height - 100, 100, 40)];
    self.playBtn.backgroundColor = [UIColor blueColor];
    [self.playBtn addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playBtn];
    
    self.animationView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 60, 30)];
    self.animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.animationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onClicked:(id)sender
{
    [UIView animateWithDuration:3
                          delay:0
         usingSpringWithDamping:0.3
          initialSpringVelocity:4
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        self.animationView.frame = CGRectMake(100, 400, 60, 30);
    } completion:^(BOOL finished) {
        
    }];
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
