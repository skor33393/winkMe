//
//  VKFriendsStorage.h
//  winkMe
//
//  Created by Admin on 25.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VKFriendsStorageDelegate <NSObject>

- (void)VKFriendsStorageDidReceivefriendsList;

@end

@interface VKFriendsStorage : NSObject
{
@private
    NSArray *friends;
}

@property (nonatomic, weak) id <VKFriendsStorageDelegate> delegate;

+ (NSArray *)getFriends;

@end
