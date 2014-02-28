//
//  VKFriendsStorage.h
//  winkMe
//
//  Created by Admin on 25.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKFriendsStorage : NSObject
{
    NSArray *friends;
}

@property BOOL cached;

+ (VKFriendsStorage *)sharedStorage;
- (void)fetchFriendsWithCompletion:(void (^)(NSArray *friends, NSError *error))block;

@end
