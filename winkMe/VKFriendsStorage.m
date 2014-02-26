//
//  VKFriendsStorage.m
//  winkMe
//
//  Created by Admin on 25.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "VKFriendsStorage.h"
#import "VKRequest.h"

@implementation VKFriendsStorage

static VKFriendsStorage *friendsStorage = nil;

#pragma mark Initialization

+ (void)initialize {
	NSAssert([VKFriendsStorage class] == self, @"Subclassing is not welcome");
	friendsStorage = [[super alloc] initUniqueInstance];
}

- (instancetype)initUniqueInstance {
	self = [super init];
    
    NSString *requestString = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?"
                               "uid=%@&fields=first_name,last_name,photo", [VKSdk getVkID]];
    
    NSURL *url = [NSURL URLWithString:requestString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSError *jsonError = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    if (jsonObject != nil && error == nil) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            friends = [jsonObject objectForKey:@"response"];
        }
    }
    
    /*NSOperationQueue *queue = [[NSOperationQueue alloc] init];
     [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (jsonObject != nil && error == nil) {
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                friends = [jsonObject objectForKey:@"response"];
            }
        }
    }];*/
    
    return self;
}

+ (instancetype)instance {
	if (!friendsStorage) {
		[NSException raise:@"VKSdk should be initialized" format:@"Use [VKSdk initialize:delegate] method"];
	}
	return friendsStorage;
}

+ (NSArray *)getFriends {
    return friendsStorage->friends;
}

@end
