//
//  VKFriend.m
//  winkMe
//
//  Created by Admin on 28.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "VKFriend.h"

@implementation VKFriend

-(id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.vkID = [dict objectForKey:@"uid"];
        self.fullName = [NSString stringWithFormat:@"%@ %@", [dict objectForKey:@"first_name"], [dict objectForKey:@"last_name"]];
        self.photoURL = [dict objectForKey:@"photo"];
        self.photo = nil;
    }
    return self;
}

@end
