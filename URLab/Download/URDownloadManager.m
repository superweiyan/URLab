//
//  URDownloadManager.m
//  URLab
//
//  Created by lin weiyan on 11/03/2018.
//  Copyright © 2018 lin weiyan. All rights reserved.
//

/**
 * 重构，下载这块分为3部分来做，
 * 1、data，多数时候用于json格式。
 * 2、download 用于下载类似大容量的文件，比如音视频文件；
 * 3、upload 上传文件到服务器，比如提交反馈文件
 */

#import "URDownloadManager.h"

@interface URDownloadManager()<NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession  *urlSession;
@property (nonatomic, strong) NSData        *downloadData;

@end

@implementation URDownloadManager

+ (URDownloadManager *)sharedObject
{
    static URDownloadManager *sharedManager;
    static dispatch_once_t sharedManagerOnce;
    dispatch_once(&sharedManagerOnce, ^{
        sharedManager = [[URDownloadManager alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlSession = [NSURLSession sharedSession];
    }
    return self;
}

- (void)startDownload:(NSString *)url
{
    NSURLSessionConfiguration *cofiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:cofiguration delegate:self delegateQueue:nil];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:url]];
    [downloadTask resume];
}

- (void)pauseDownload:(NSString *)url
{
    
}

- (void)cancelDownload:(NSString *)url
{
    
}

//==================================

//下载结束
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
//    NSLog(@"finish download %@, %@", location.filePathURL, downloadTask.response.suggestedFilename);
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:nil];
}

//用来通知下载进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"download %lld, hadDownload %lld, total %lld, percent", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    
    __weak __typeof(self) weakSelf = self;
    if (self.downloadBlock && totalBytesExpectedToWrite > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.downloadBlock(1.0 * totalBytesWritten / totalBytesExpectedToWrite);
        });
        
    }
}



@end
