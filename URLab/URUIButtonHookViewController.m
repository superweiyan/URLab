//
//  URUIButtonHookViewController.m
//  URLab
//
//  Created by lin weiyan on 06/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URUIButtonHookViewController.h"
#import "UIButton+Hook.h"

@interface URUIButtonHookViewController ()

@property (nonatomic, strong) UIButton  *testBtn;

@end

@implementation URUIButtonHookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.testBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    self.testBtn.backgroundColor = [UIColor redColor];
    [self.testBtn addTarget:self action:@selector(onTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
