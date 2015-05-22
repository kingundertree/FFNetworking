//
//  FFNetService.m
//  FFMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "FFNetService.h"
#import "FFAppContext.h"

@implementation FFNetService

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(FFNetServiceProtocal)]) {
            self.child = (id<FFNetServiceProtocal>)self;
        }
    }
    return self;
}

#pragma mark - getters and setters

- (BOOL)isOldApi
{
    return NO;
}

- (BOOL)isREST
{
    return NO;
}

- (NSString *)appName
{
    return [[FFAppContext sharedInstance] appName];
}

- (NSString *)privateKey
{
    return self.child.isOnline ? self.child.onlinePrivateKey : self.child.offlinePrivateKey;
}

- (NSString *)publicKey
{
    return self.child.isOnline ? self.child.onlinePublicKey : self.child.offlinePublicKey;
}

- (NSString *)apiBaseUrl
{
    return self.child.isOnline ? self.child.onlineApiBaseUrl : self.child.offlineApiBaseUrl;
}

- (NSString *)apiVersion
{
    return self.child.isOnline ? self.child.onlineApiVersion : self.child.offlineApiVersion;
}

@end
