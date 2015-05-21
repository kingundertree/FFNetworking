//
//  FFNetCommonParamsGenerator.m
//  FFMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "FFNetCommonParamsGenerator.h"
#import "FFAppContext.h"
#import "UIDevice+FFIdentifierAddition.h"

@implementation FFNetCommonParamsGenerator
+ (NSDictionary *)commonParamsDictionary
{
    FFAppContext *context = [FFAppContext sharedInstance];
    
    //@"cid":context.cid,
    return @{@"ostype2":context.ostype2,
                                  @"udid2":context.udid2,
                                  @"uuid2":context.uuid2,
                                  @"app":context.appName,
                                  @"cv":context.cv,
                                  @"from":context.from,
                                  @"m":context.m,
                                  @"macid":context.macid,
                                  @"o":context.o,
                                  @"pm":context.pm,
                                  @"qtime":context.qtime,
                                  @"uuid":context.uuid,
                                  @"i":context.i,
                                  @"v":context.v
                                  };
}

+ (NSDictionary *)commonParamsDictionaryForLog
{
    FFAppContext *context = [FFAppContext sharedInstance];
    return @{
             @"guid":context.guid,
             @"dvid":context.dvid,
             @"net":context.net,
             @"ver":context.ver,
             @"ip":context.ip,
             @"mac":context.mac,
             @"geo":context.geo,
             @"uid":context.uid,
             @"chat_id":context.chatid,
             @"ccid":context.ccid,
             @"gcid":context.gcid,
             @"p":context.p,
             @"os":context.os,
             @"v":context.v,
             @"app":context.app,
             @"ch":context.channelID,
             @"ct":context.ct,
             @"pmodel":context.pmodel
             };
}

+ (NSDictionary *)sigCommParamsOldWithService:(FFNetService<FFNetServiceProtocal> *)service
{
    FFAppContext *context = [FFAppContext sharedInstance];
    return @{
             @"i":[[UIDevice currentDevice] FFNet_udid],
             @"macid":context.macid,
             @"m":context.m,
             @"o":context.os,
             @"v":context.v,
             @"cv":context.cv,
             @"pm":context.channelID,
             @"app":service.appName,
             @"cid":context.cid
             };
}

+ (NSDictionary *)outSigCommParamsOldWithService:(FFNetService<FFNetServiceProtocal> *)service
{
    FFAppContext *context = [FFAppContext sharedInstance];
    return @{
             @"ostype2": context.ostype2,
             @"udid2": context.udid2,
             @"uuid2": context.uuid2
             };
}

@end
