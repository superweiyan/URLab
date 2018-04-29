//
//  URAnimationListViewController.m
//  URLab
//
//  Created by lin weiyan on 21/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URAnimationListViewController.h"
#import "UIViewController+PushView.h"

@interface URAnimationListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   *animationTableView;
@property (nonatomic, strong) NSArray       *itemArray;

@end

@implementation URAnimationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.animationTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.animationTableView.delegate = self;
    self.animationTableView.dataSource = self;
    [self.view addSubview:self.animationTableView];
    
    self.itemArray = @[@"气泡"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.animationTableView.delegate = nil;
    self.animationTableView.dataSource = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"animtionCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"animtionCell"];
    }
    
    if (indexPath.row < self.itemArray.count) {
        cell.textLabel.text = [self.itemArray objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.itemArray.count) {
        [self pushView:@"URBubbleViewController"];
    }
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
