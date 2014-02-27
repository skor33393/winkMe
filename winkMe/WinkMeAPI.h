//
//  WinkMeAPI.h
//  winkMe
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WinkMeAPI : NSObject

+ (void)likeUserWithID:(NSString *)userID andCompletionBlock:(void (^)(NSData *result, NSError *error))block;

@end
