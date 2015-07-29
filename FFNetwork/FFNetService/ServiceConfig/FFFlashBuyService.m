//
//  FFFlashBuyService.m
//  FFNetworking
//
//  Created by xiazer on 15/7/29.
//  Copyright (c) 2015年 freshfresh. All rights reserved.
//

#import "FFFlashBuyService.h"
#import "FFAppContext.h"

@implementation FFFlashBuyService

- (BOOL)isOnline
{
    return [[FFAppContext sharedInstance] isApiOnline];
}

- (NSString *)onlineApiBaseUrl
{
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSString *versionStr = self.versionWithPathDic[version];
//    if (versionStr && versionStr.length > 0) {
//        return [NSString stringWithFormat:@"http://www.freshfresh.com/mobile/%@/index/uri/",versionStr];
//    } else {
//        return [NSString stringWithFormat:@"http://www.freshfresh.com/mobile/%@/index/uri/",@"1.0"];
//    }
    return @"http://192.168.10.234:9009/";
}

- (NSString *)onlineApiVersion
{
    return @"";
}

- (NSString *)onlinePrivateKey
{
    return @"";
}

- (NSString *)onlinePublicKey
{
    return @"";;
}

- (NSString *)offlineApiBaseUrl
{
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSString *versionStr = self.versionWithPathDic[version];
//    if (versionStr && versionStr.length > 0) {
//        return [NSString stringWithFormat:@"http://test.freshfresh.com/fresh2014/mobile/%@?uri=",versionStr];
//    } else {
//        return [NSString stringWithFormat:@"http://test.freshfresh.com/fresh2014/mobile/%@?uri=",@"1.0"];
//    }
    return @"http://192.168.10.234:9009/";
}

- (NSString *)offlineApiVersion
{
    return @"";
}

- (NSString *)offlinePrivateKey
{
    return @"";
}

- (NSString *)offlinePublicKey
{
    return @"";
}


@end
