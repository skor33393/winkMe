//
//  VKSdk.h
//  winkMe
//
//  Created by Admin on 24.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKRequest.h"

@protocol VKSdkDelegate <NSObject>

@required
- (void)VKSdkDidReceiveNewToken;
- (void)VKSdkTokenFail;

@end

@interface VKSdk : NSObject
{
@private
    NSString *_vkID;
    NSString *_hash;
    NSString *_accessToken;
    NSString *_appID;
}

@property (nonatomic, weak) id <VKSdkDelegate> delegate;

+ (void)inithWithDelegate:(id <VKSdkDelegate>)delegate;
+ (void)authWithClientID:(NSString *)clientID andScope:(NSString *)scope andRedirectURI:(NSString *)redirectURI;
+ (void)handleOpenURL:(NSURL *)url;
+ (void)setAccessToken:(NSString *)accessToken;
+ (NSString *)getAccessToken;
+ (void)setHash:(NSString *)hash;
+ (NSString *)getHash;
+ (void)setVkID:(NSString *)vkID;
+ (NSString *)getVkID;

@end
