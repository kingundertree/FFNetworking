//
//  FFRequestGenerator.m
//  FFMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "FFRequestGenerator.h"
#import "FFSignatureGenerator.h"
#import "FFNetCommonParamsGenerator.h"
#import "NSDictionary+FFNetMethod.h"
#import "FFSignatureGenerator.h"
#import "FFNetServiceFactory.h"
#import "FFNetCommonParamsGenerator.h"
#import "NSObject+FFNetMethod.h"
#import <AFNetworking/AFNetworking.h>
#import "FFNetService.h"
#import "AFURLRequestSerialization.h"
#import "NSURLRequest+FFNetMethod.h"
#import "FFNetServiceFactory.h"
#import "FFNetDebug.h"

static NSString * const httpMethodRestfulGet = @"GET";
static NSString * const httpMethodRestfulPost = @"POST";
static NSString * const httpMethodRestfulPut = @"PUT";
static NSString * const httpMethodRestfulDelete = @"DELETE";

static NSTimeInterval kAIFNetworkingTimeoutSeconds = 20.0f;

@interface FFRequestGenerator ()
@property(nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@end

@implementation FFRequestGenerator

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static FFRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FFRequestGenerator alloc] init];
    });
    return sharedInstance;
}


#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = 20;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName{
    FFNetService *service = [[FFNetServiceFactory shareInstance] serviceWithIdentifier:serviceIdentifier];

    NSMutableDictionary *sigParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
//    sigParams[@"api_key"] = service.publicKey;
    NSString *signature = [FFSignatureGenerator signGetWithSigParams:sigParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey];

    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[FFNetCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:sigParams];
//    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@&sig=%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams FFNet_urlParamsStringSignature:NO], signature];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@?%@&sig=%@", service.apiBaseUrl, methodName, [allParams FFNet_urlParamsStringSignature:NO], signature];

    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = 20;
    request.requestParams = requestParams;
    
    [FFNetDebug logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"GET"];
    return request;
}

- (NSURLRequest *)generatePostRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName{
    FFNetService *service = [[FFNetServiceFactory shareInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSString *signature = [FFSignatureGenerator signPostWithApiParams:requestParams privateKey:service.privateKey publicKey:service.publicKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?api_key=%@&sig=%@&%@", service.apiBaseUrl, service.apiVersion, methodName, service.publicKey, signature, [[FFNetCommonParamsGenerator commonParamsDictionary] FFNet_urlParamsStringSignature:NO]];

    NSURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
    request.requestParams = requestParams;

    [FFNetDebug logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"POST"];
    return request;
}

- (NSURLRequest *)generateRestfulGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName httpMethod:(NSString *)httpMethod
{
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[FFNetCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:requestParams];

    FFNetService *service = [[FFNetServiceFactory shareInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *signature = [FFSignatureGenerator signRestfulGetWithAllParams:requestParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams FFNet_urlParamsStringSignature:NO]];
    
    NSDictionary *restfulHeader = [self commRESTHeadersWithService:service signature:signature];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kAIFNetworkingTimeoutSeconds];
    request.HTTPMethod = httpMethod;
    [restfulHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    request.requestParams = requestParams;

    [FFNetDebug logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:[NSString stringWithFormat:@"Restful %@",httpMethod]];
    return request;
}

- (NSURLRequest *)generateRestfulPOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName httpMethod:(NSString *)httpMethod{
    FFNetService *service = [[FFNetServiceFactory shareInstance] serviceWithIdentifier:serviceIdentifier];
    NSDictionary *commonParams = [FFNetCommonParamsGenerator commonParamsDictionary];
    NSString *signature = [FFSignatureGenerator signRestfulPOSTWithApiParams:requestParams commonParams:commonParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@", service.apiBaseUrl, service.apiVersion, methodName, [commonParams FFNet_urlParamsStringSignature:NO]];
    
    NSDictionary *restfulHeader = [self commRESTHeadersWithService:service signature:signature];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kAIFNetworkingTimeoutSeconds];
    request.HTTPMethod = httpMethod;
    [restfulHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:NSJSONWritingPrettyPrinted error:NULL];
    request.requestParams = requestParams;
    
    [FFNetDebug logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:[NSString stringWithFormat:@"Restful %@",httpMethod]];

    return request;
}

- (NSURLRequest *)generateRestfulGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    return [self generateRestfulGETRequestWithServiceIdentifier:serviceIdentifier requestParams:requestParams methodName:methodName httpMethod:httpMethodRestfulGet];
}

- (NSURLRequest *)generateRestfulPOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    return [self generateRestfulPOSTRequestWithServiceIdentifier:serviceIdentifier requestParams:requestParams methodName:methodName httpMethod:httpMethodRestfulGet];
}

#pragma mark - private methods
- (NSDictionary *)commRESTHeadersWithService:(FFNetService *)service signature:(NSString *)signature
{
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    [headerDic setValue:signature forKey:@"sig"];
    [headerDic setValue:service.publicKey forKey:@"key"];
    [headerDic setValue:@"application/json" forKey:@"Accept"];
    [headerDic setValue:@"application/json" forKey:@"Content-Type"];

#warning test token
    NSString *token = @"OxXjntKz8Hv+G5b2Qts8L6AIlMaQz/FCT/LX1f+A61Hrx36tysEvFtoV7DV64sKB2+2garTXQBIeoHl0rfsuOi1fyoEIPrA5ynNfDk5gGoR8YTRSQiXkVFFpVmuzwDD7Um/BVbq2UK693Wr3/vbI/uzpHY61Gv6bp9j6oOO3zEgoo4kZJa2tgCEUxgm2MOBoDRe7F9ZmOQAXlGkqwZBtFcHTOEeLGVZBSQplNAxrHunHz5bkTwfQnrxdn50nCcbhWCtfulRYC+/jkLObSbPHmA==";
    if (token) {
        [headerDic setValue:token forKey:@"AuthToken"];
    }
//    NSDictionary *loginResult = [[NSUserDefaults standardUserDefaults] objectForKey:@"anjuke_chat_login_info"];
//    if (loginResult[@"auth_token"]) {
//        [headerDic setValue:loginResult[@"auth_token"] forKey:@"AuthToken"];
//    }
    return headerDic;
}

@end