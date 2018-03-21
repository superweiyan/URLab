//
//  URTextContaintViewController.m
//  URLab
//
//  Created by lin weiyan on 10/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import "URTextContaintViewController.h"

@interface URTextContaintViewController ()

@property (nonatomic, strong) NSArray *originArray;
@property (nonatomic, strong) NSArray *moreArray;

@end

@implementation URTextContaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.originArray = [self loadOriginData];
    self.moreArray = [self getMoreArray];
    [self compareTxt];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)loadOriginData
{
    NSDictionary *info = [self getConfigFromName:@"origin.geojson"];
    return [info objectForKey:@"coordinates"];
}

- (void)compareTxt
{
    NSMutableArray *allUids = [[NSMutableArray alloc] initWithArray:self.originArray];
    
    for (int i = 0; i < self.moreArray.count; i++) {
        NSString *newUid = [self.moreArray objectAtIndex:i];
        
        BOOL hadFind = NO;
        for (int i = 0; i < self.originArray.count; i++) {
            
            NSString *uid = [self.originArray objectAtIndex:i];
            if ([newUid isEqualToString:uid]) {
                hadFind = YES;
            }
        }
        
        if (!hadFind) {
            [allUids addObject:newUid];
        }
    }
    
//    NSLog(@"count:%ld, %@", allUids.count, allUids);
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0; i < allUids.count; i++) {
        NSString *x = [allUids objectAtIndex:i];
        [result appendString:[NSString stringWithFormat:@"\n\"%@\",", x]];
    }
    NSLog(@"result %@", result);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSDictionary *)getConfigFromName:(NSString *)configName
{
    NSString *parseJason = [self getFileContent:configName];
    NSData *data = [parseJason dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *serialization = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"serialization error : %@", error.localizedDescription);
        return nil;
    }
    return serialization;
}

- (NSString *)getFileContent:(NSString *)configName
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *strPath = [bundle pathForResource:configName ofType:nil];
    NSError *error;
    NSString *parseJason = [[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"parseJason error : %@", error.localizedDescription);
        return nil;
    }
    return parseJason;

}

- (NSArray *)getMoreArray
{
    NSString *json = [self getFileContent:@"uids.txt"];
    NSArray *uids = [json componentsSeparatedByString:@"\n"];
    NSMutableArray *uidArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < uids.count; i++) {
        NSString *uid = [uids objectAtIndex:i];
        if ([uid hasSuffix:@"\r"]) {
            [uidArray addObject:[uid substringToIndex:(uid.length - 1)]];
        }
        else {
            [uidArray addObject:uid];
        }
    }
    return uidArray;
}

@end
