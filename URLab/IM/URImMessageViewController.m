//
//  URImMessageViewController.m
//  URLab
//
//  Created by lin weiyan on 08/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URImMessageViewController.h"
#import "URImToolView.h"
#import "URPFSView.h"
#import "URTextTableViewCell.h"
#import "NSString+Utils.h"

@interface URImMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) URImToolView      *toolView;
@property (nonatomic, strong) UITableView       *messageTableView;
@property (nonatomic, strong) NSMutableArray    *msgArray;

@property (nonatomic, assign) CGFloat           inputHeight;
@property (nonatomic, strong) NSMutableArray    *msgQueue;
@property (nonatomic, strong) NSTimer           *msgTimer;
@property (nonatomic, strong) NSMutableArray    *heightArray;

@end

@implementation URImMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.msgArray = [[NSMutableArray alloc] init];
    self.msgQueue = [[NSMutableArray alloc] init];
    self.heightArray = [[NSMutableArray alloc] init];
    
    self.messageTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    [self.view addSubview:self.messageTableView];
    
    self.toolView = [[URImToolView alloc] init];
    self.toolView.backgroundColor = [UIColor redColor];
    __weak __typeof(self) weakSelf = self;
    self.toolView.sendBlock = ^(NSString *text) {
        [weakSelf addMsg:text];
    };
    
    [self.view addSubview:self.toolView];
    
    [self initNotification];
    [self initGesture];
    
//    __weak __typeof (self) weakSelf = self;
    self.msgTimer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(showLastestMsg) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.msgTimer forMode:NSDefaultRunLoopMode];
//    [self.msgTimer fire];
    
    URPFSView *pfsView = [[URPFSView alloc] initWithFrame:CGRectMake(300, 70, 70, 15)];
    pfsView.backgroundColor = [UIColor redColor];
    [self.view addSubview:pfsView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardWillHideNotification:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)initGesture
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [self.messageTableView addGestureRecognizer:gesture];
}

- (void)onTap
{
    [self.toolView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addMsg:(NSString *)msg
{
    [self.msgQueue addObject:msg];
//    [self.messageTableView reloadData];
}

- (void)showLastestMsg
{
    if (self.msgQueue.count == 0) {
        return ;
    }
    
    NSLog(@"+++++++++++++++++++++++++");
    
    NSString *msg = [self.msgQueue firstObject];
    [self.msgQueue removeObjectAtIndex:0];

    [self.msgArray addObject:msg];
    NSIndexPath *path = [NSIndexPath indexPathForRow:(self.msgArray.count-1) inSection:0];
    [self.messageTableView beginUpdates];
    [self.messageTableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.messageTableView endUpdates];
    
    [self.messageTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.toolView.frame = CGRectMake(0, screenSize.height - 60 - self.inputHeight, screenSize.width, 60);
    self.messageTableView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height - 60 - self.inputHeight);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.msgArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    URTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msgCellIndentifer"];
    if (!cell) {
        cell = [[URTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"msgCellIndentifer"];
    }
    
    if (indexPath.row % 2 == 0)  {
        cell.backgroundColor = [UIColor greenColor];
    }
    else {
        cell.backgroundColor = [UIColor blueColor];
    }
    
    NSLog(@"+++++ 4");
    
//    if (indexPath.row < self.msgArray.count) {
//        cell.textLabel.text = [self.msgArray objectAtIndex:indexPath.row];
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = [self.heightArray objectAtIndex:indexPath.row];
    NSLog(@"+++++ 1 %@", height);
    return height.floatValue;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *txt = [self.msgArray objectAtIndex:indexPath.row];
    CGFloat height = [self calcHeight:txt];
    NSLog(@"+++++ 2 %f", height);
    [self.heightArray insertObject:@(height) atIndex:indexPath.row];
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.msgArray.count) {
        
        NSLog(@"+++++ 3");
        NSString *txt = [self.msgArray objectAtIndex:indexPath.row];
        
        URTextTableViewCell *newCell = ((URTextTableViewCell *)cell);
        [newCell updateInfo:txt];
    }
}

#pragma mark - notification

- (void)onKeyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.inputHeight = keyboardSize.height;
    [self.view setNeedsLayout];
}

- (void)onKeyboardWillHideNotification:(NSNotification *)notification
{
//    NSDictionary *userInfo = notification.userInfo;
//    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.inputHeight = 0;
    [self.view setNeedsLayout];
}

#pragma mark - helper

- (CGFloat)calcHeight:(NSString *)txt
{
    return [txt textWidth:[UIFont systemFontOfSize:17] width:100] + 10;
}

//- (float) heightForString:(UITextView *)textView andWidth:(float)width{
//    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
//    return sizeToFit.height;
//}

@end
