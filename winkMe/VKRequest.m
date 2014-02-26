//
//  VKRequest.m
//  winkMe
//
//  Created by Admin on 25.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "VKRequest.h"

@implementation VKRequest

+ (NSArray *)getFriends {
    NSString *requestString = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?"
                               "uid=%@&fields=first_name,last_name,photo", [VKSdk getVkID]];
    
    NSURL *url = [NSURL URLWithString:requestString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    __block NSArray* result = nil;
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (jsonObject != nil && error == nil) {
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                result = [jsonObject objectForKey:@"response"];
                NSLog(@"%@", result);
            }
        }
    }];
    
    return result;
}

@end
