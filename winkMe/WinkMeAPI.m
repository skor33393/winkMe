//
//  WinkMeAPI.m
//  winkMe
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "WinkMeAPI.h"
#import "WinkMeAPIConnection.h"
#import "VKSdk.h"

@implementation WinkMeAPI

+ (void)likeUserWithID:(NSString *)userID andCompletionBlock:(void (^)(NSData *, NSError *))block {
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"vk_id\":%@, \"hash\":\"%@\", \"honey_vk_id\":%@} ", [VKSdk getVkID], [VKSdk getHash], userID];
    
    NSURL *url = [NSURL URLWithString:@"http://www.innocraft.net/addHoney"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    WinkMeAPIConnection *connection = [[WinkMeAPIConnection alloc] initWithReuest:request];
    
    [connection setCompletionBlock:block];
    
    [connection start];
}

@end
