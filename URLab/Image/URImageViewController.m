//
//  URImageViewController.m
//  URLab
//
//  Created by lin weiyan on 23/04/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URImageViewController.h"
#import "URImageCheckTypeViewController.h"

@interface URImageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView                   *imageOptList;
@property (nonatomic, strong) NSArray<NSString *>           *imageTypeList;

@end

@implementation URImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.imageTypeList = @[@"图片类型"];
    
    self.imageOptList = [[UITableView alloc] init];
    self.imageOptList.delegate = self;
    self.imageOptList.dataSource = self;
    [self.view addSubview:self.imageOptList];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.imageOptList.frame = self.view.bounds;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageTypeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIndentifier"];
    if (indexPath.row < self.imageTypeList.count) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIndentifier"];
    }
    
    NSString *txt = [self.imageTypeList objectAtIndex:indexPath.row];
    cell.textLabel.text = txt;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        URImageCheckTypeViewController *controller = [[URImageCheckTypeViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
