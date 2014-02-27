//
//  VKFriendsStorageConnection.h
//  winkMe
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKFriendsStorageConnection : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSURLConnection *internalConnection;
    NSMutableData *container;
}

@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy) void (^completionBlock)(id obj, NSError *error);

- (id)initWithReuest:(NSURLRequest *)request;
- (void)start;


@end
