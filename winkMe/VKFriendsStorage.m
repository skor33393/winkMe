//
//  VKFriendsStorage.m
//  winkMe
//
//  Created by Admin on 25.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "VKFriendsStorage.h"
#import "VKRequest.h"
#import "VKFriendsStorageConnection.h"

@implementation VKFriendsStorage

#pragma mark Initialization

+ (VKFriendsStorage *)sharedStorage {
    static VKFriendsStorage *sharedStorage = nil;
    if (!sharedStorage) {
        sharedStorage = [[VKFriendsStorage alloc] init];
        sharedStorage.cached = NO;
    }
    
    return sharedStorage;
}

- (void)fetchFriendsWithCompletion:(void (^)(NSArray *, NSError *))block {
  
    if (self->friends) {
        NSLog(@"cached friends");
        block(self->friends, nil);
        return;
    }
    
    NSString *requestString = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?"
                               "uid=%@&fields=first_name,last_name,photo", [VKSdk getVkID]];
    
    NSURL *url = [NSURL URLWithString:requestString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    VKFriendsStorageConnection *connection = [[VKFriendsStorageConnection alloc] initWithReuest:request];
    
    //[connection setCompletionBlock:block];
    
    [connection setCompletionBlock:^(NSArray *obj, NSError *error) {
        self->friends = obj;
        
        block(obj, error);
    }];
    
    [connection start];
}


@end
