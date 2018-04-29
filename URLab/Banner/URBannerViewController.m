//
//  URBannerViewController.m
//  URLab
//
//  Created by lin weiyan on 31/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URBannerViewController.h"
#import "MFBannerView.h"

@interface URBannerViewController ()

@property (nonatomic, strong)  MFBannerView *bannerView;

@end

@implementation URBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
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

- (void)initViews
{
    self.bannerView = [[MFBannerView alloc] initWithFrame:CGRectMake(10, 100, 350, 100)];
    [self.view addSubview:self.bannerView];
}
@end
