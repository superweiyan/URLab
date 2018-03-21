//
//  URDownloadViewController.m
//  URLab
//
//  Created by lin weiyan on 11/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URDownloadViewController.h"
#import "URDownloadManager.h"

static NSString *kDownloadURL = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";

@interface URDownloadViewController ()

@property (nonatomic, strong) UILabel       *showPercentLabel;
@property (nonatomic, strong) UIButton      *startDownload;
@property (nonatomic, strong) UIButton      *cancelDownload;

@end

@implementation URDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.showPercentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 20)];
    self.showPercentLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.showPercentLabel];
    
    self.startDownload = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 20)];
    [self.startDownload addTarget:self action:@selector(onStartDownload) forControlEvents:UIControlEventTouchUpInside];
    [self.startDownload setTitle:@"开始" forState:UIControlStateNormal];
    [self.startDownload setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.startDownload];
    
    self.cancelDownload = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 20)];
    [self.cancelDownload addTarget:self action:@selector(onCancelDownload) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelDownload setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelDownload setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.cancelDownload];
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

- (void)onStartDownload
{
    URDownloadManager *manager = [URDownloadManager sharedObject];
    [manager startDownload:kDownloadURL];
    __weak __typeof(self) weakSelf = self;
    manager.downloadBlock = ^(float percent) {
        weakSelf.showPercentLabel.text = @(percent).stringValue;
    };
}

- (void)onCancelDownload
{
    [[URDownloadManager sharedObject] cancelDownload:kDownloadURL];
}

@end
