//
//  FFRequestResponse+FFNetMethod.m
//  FFMusic
//
//  Created by xiazer on 14/10/22.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "FFRequestResponse+FFNetMethod.h"

@implementation FFRequestResponse (FFNetMethod)
- (void)updateWithRTNetworkResponse:(FFRequestResponse *)response
{
    enum FFNetWorkingResponseStatus status;
    if (response.status == FFNetWorkingResponseStatusSuccess) {
        status = FFNetWorkingResponseStatusSuccess;
    } else {
        status = FFNetWorkingResponseStatusError;
    }
    
    [self updateWithContent:response.content requestId:response.requestID status:status];
}

- (FFRequestResponse *)returnNetworkResponse
{
    FFRequestResponse *response = [[FFRequestResponse alloc] init];
    response.requestID = (FFRequestID)self.requestId;
    if (self.status == FFNetWorkingResponseStatusSuccess) {
        response.status = FFNetWorkingResponseStatusSuccess;
    } else {
        response.status = FFNetWorkingResponseStatusError;
    }
    response.content = self.content;
    
    return response;
}

@end
