//
//  URBubbleViewController.m
//  URLab
//
//  Created by lin weiyan on 21/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URBubbleViewController.h"
#import "URBubbyLayer.h"

@interface URBubbleViewController ()

@property (nonatomic, strong) UIView            *originView;
@property (nonatomic, strong) UIView            *destView;
@property (nonatomic, strong) URBubbyLayer      *bubbleLayer;

@end

@implementation URBubbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"气泡";
    
    self.originView = [[UIView alloc] initWithFrame:CGRectMake(100, 500, 50, 50)];
    self.originView.layer.cornerRadius = 25;
    self.originView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.originView];
    
    self.destView = [[UIView alloc] initWithFrame:CGRectMake(100, 500, 50, 50)];
    self.destView.layer.cornerRadius = 25;
    self.destView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.destView];
    
    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
    [self.destView addGestureRecognizer:tap];
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

- (void)onTapGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
//    NSLog(@"+++ %f, %f", translation.x, translation.y);
    
    CGPoint newCenter = CGPointMake(recognizer.view.center.x + translation.x,
                                    recognizer.view.center.y);
    
    recognizer.view.center = newCenter;
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    [self drawSpace:newCenter];
}

- (void)drawSpace:(CGPoint)destPoint
{
    CGPoint originPoint = CGPointMake(125, 525);
    
    CGFloat distant = sqrtf((destPoint.y - originPoint.y) * (destPoint.y - originPoint.y) +
                            (destPoint.x - originPoint.x) * (destPoint.x - originPoint.x));
    
    if (!self.bubbleLayer) {
        self.bubbleLayer = [[URBubbyLayer alloc] init];
        [self.view.layer addSublayer:self.bubbleLayer];
        self.bubbleLayer.indicatorColor = [UIColor blueColor];
    }
    
//    CGFloat bubbleLayerX = originPoint.x;
//    CGFloat bubbleLayerY = destPoint.y
    CGFloat height = 50 * ((destPoint.x - originPoint.x) / 50 - 1);
    self.bubbleLayer.offset = (destPoint.y - originPoint.y ) / 6;
    self.bubbleLayer.frame = CGRectMake( originPoint.x,  destPoint.y - height/2, destPoint.x - originPoint.x, height);
    [self.bubbleLayer setNeedsDisplay];
}

@end
