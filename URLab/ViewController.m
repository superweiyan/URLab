//
//  ViewController.m
//  URLab
//
//  Created by lin weiyan on 02/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "ViewController.h"
#import "URAnimationViewController.h"
#import "URUIButtonHookViewController.h"
#import "URImMessageViewController.h"
#import "URTextContaintViewController.h"
#import "URDownloadViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *itemTableView;
@property (nonatomic, strong) NSArray           *itemArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.itemTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.itemTableView];
    self.itemTableView.delegate = self;
    self.itemTableView.dataSource = self;
    
    self.itemArray = @[@"动画", @"hook UIButton", @"IM", @"字符串比较", @"下载"];
}

- (void)dealloc
{
    self.itemTableView.delegate = nil;
    self.itemTableView.dataSource = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCellIndentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCellIndentifier"];
    }
    
    if (indexPath.row < self.itemArray.count) {
        cell.textLabel.text = [self.itemArray objectAtIndex:indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.itemArray.count) {
        if (indexPath.row == 0) {
            URAnimationViewController *controller = [[URAnimationViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if (indexPath.row == 1) {
            URUIButtonHookViewController *controller = [[URUIButtonHookViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if (indexPath.row == 2) {
            URImMessageViewController *msgController = [[URImMessageViewController alloc] init];
            [self.navigationController pushViewController:msgController animated:YES];
            
        }
        else if (indexPath.row == 3) {
//            URTextContaintViewController *controller = [[URTextContaintViewController alloc] init];
//            [self.navigationController pushViewController:msgController animated:YES];
            [self pushView:@"URTextContaintViewController"];
        }
        else if (indexPath.row == 4) {
            [self pushView:@"URDownloadViewController"];
        }
    }
}

- (void)pushView:(NSString *)name
{
    Class cls = NSClassFromString(name);
    UIViewController *vc = [[cls alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
