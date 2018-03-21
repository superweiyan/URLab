//
//  URDownloadManager.h
//  URLab
//
//  Created by lin weiyan on 11/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^downloadPercentCallback)(float);


@interface URDownloadManager : NSObject

+ (URDownloadManager *)sharedObject;

@property (nonatomic, copy)  downloadPercentCallback downloadBlock;

- (void)startDownload:(NSString *)url;
- (void)pauseDownload:(NSString *)url;
- (void)cancelDownload:(NSString *)url;
@end
