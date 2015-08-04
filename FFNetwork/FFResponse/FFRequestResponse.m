//
//  FFRequestResponse.m
//  FFMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "FFRequestResponse.h"
#import "NSObject+FFNetMethod.h"
#import "NSURLRequest+FFNetMethod.h"

@interface FFRequestResponse ()
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;
@end

@implementation FFRequestResponse

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(enum FFNetWorkingResponseStatus)status
{
    self = [super init];
    if (self) {
        self.contentString = [responseString FFNet_defaultValue:@""];
        self.status = [self responseStatusWithRequestString:responseString];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        self.content = [self createContentWithData:self.responseData];
    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.contentString = [responseString FFNet_defaultValue:@""];
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        self.content = [self createContentWithData:self.responseData];
    }
    return self;
}


#pragma mark - private methods
- (enum FFNetWorkingResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        enum FFNetWorkingResponseStatus result = FFNetWorkingResponseStatusError;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = FFNetWorkingResponseStatusTimeOut;
        } else {
            if ([error isKindOfClass:[NSDictionary class]]) {
                NSDictionary *requestDic = (NSDictionary *)error;
                if (![requestDic[@"result"] isEqualToString:@"1"]) {
                    NSString *errcode = [self isBlankString:requestDic[@"errorcode"]] ? @"" : requestDic[@"errorcode"];
                    NSString *errMsg = requestDic[@"data"][@"errmsg"];
                    if (errcode.length > 0 && ([errMsg isEqualToString:@"invalid customer token."])) {
                        result = FFNetWorkingResponseStatusTokenInvalid;
                        
                        return result;
                    } else {
                        result = FFNetWorkingResponseStatusError;
                    }
                }
                
            } else if ([error isKindOfClass:[NSString class]]) {
                NSString *errorCode =(NSString*)error;
                if (errorCode && [errorCode isEqualToString:@"invalid customer token."]) {
                    result = FFNetWorkingResponseStatusTokenInvalid;
                }
            }
        }
        
        return result;
    } else {
        return FFNetWorkingResponseStatusSuccess;
    }
}

- (enum FFNetWorkingResponseStatus)responseStatusWithRequestString:(NSString *)requestStr {
    enum FFNetWorkingResponseStatus result = FFNetWorkingResponseStatusSuccess;
    
//    if (requestStr) {
//        NSDictionary *requestDic = [self dictionaryWithJsonString:requestStr];
//        if (![requestDic[@"result"] isEqualToString:@"1"]) {
//            NSString *errcode = [self isBlankString:requestDic[@"errorcode"]] ? @"" : requestDic[@"errorcode"];
//            NSString *errMsg = requestDic[@"data"][@"errmsg"];
//            if (errcode.length > 0 && ([errMsg isEqualToString:@"invalid customer token."])) {
//                result = FFNetWorkingResponseStatusTokenInvalid;
//                
//                return result;
//            }
//        }
//    }
    
    return result;
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (void)updateWithContent:(id)content requestId:(NSInteger)requestId status:(enum FFNetWorkingResponseStatus)status
{
    self.content = content;
    self.requestId = requestId;
    self.status = status;
    
    if (![self checkMutableContainer:self.content]) {
        self.content = nil;
    }
}

- (id)createContentWithData:(NSData *)data
{
    id content = data ? [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] : nil;
    if (![self checkMutableContainer:content]) {
        content = nil;
    }
    
    return content;
}

- (BOOL)checkMutableContainer:(id)value
{
    return ([value isKindOfClass:[NSArray class]] ||
            [value isKindOfClass:[NSDictionary class]]);
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    //去掉前后空格,判断length是否为空
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"null"] || [string isEqualToString:@"<null>"]) {
        return YES;
    }
    
    return NO;
}

@end
