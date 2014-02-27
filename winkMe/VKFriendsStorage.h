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
@private
    NSArray *friends;
}

+ (NSArray *)getFriends;

@end
