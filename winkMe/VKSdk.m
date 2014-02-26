//
//  VKSdk.m
//  winkMe
//
//  Created by Admin on 24.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "VKSdk.h"

@implementation VKSdk

@synthesize delegate = _delegate;

static VKSdk *vkSdkInstance = nil;

#pragma mark Initialization

+ (void)initialize {
	NSAssert([VKSdk class] == self, @"Subclassing is not welcome");
	vkSdkInstance = [[super alloc] initUniqueInstance];
}

- (instancetype)initUniqueInstance {
	return [super init];
}

+ (instancetype)instance {
	if (!vkSdkInstance) {
		[NSException raise:@"VKSdk should be initialized" format:@"Use [VKSdk initialize:delegate] method"];
	}
	return vkSdkInstance;
}

+(void)inithWithDelegate:(id<VKSdkDelegate>)delegate {
    vkSdkInstance->_delegate = delegate;
}

#pragma mark Authorization

+ (void)authWithClientID:(NSString *)clientID andScope:(NSString *)scope andRedirectURI:(NSString *)redirectURI {
    NSString *path = [NSString stringWithFormat:@"https://oauth.vk.com/authorize?"
                                                "client_id=%@&scope=%@&"
                      "redirect_uri=%@&respond_type=code&v=5.9", clientID, scope, redirectURI];
    
    [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *authURL = [NSURL URLWithString:path];
    
    if([[UIApplication sharedApplication] canOpenURL:authURL]){
       [[UIApplication sharedApplication] openURL:authURL];
    }
}

+ (void)handleOpenURL:(NSURL *)url {
    NSString *fragment = [url fragment];
    NSMutableDictionary *keys = [[NSMutableDictionary alloc] init];
    for(NSString *param in [fragment componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2)
            continue;
        [keys setObject:[elts objectAtIndex:1] forKey:[elts objectAtIndex:0]];
    }
    
    if ([[keys objectForKey:@"success"] isEqualToString:@"1"]) {
        [VKSdk setAccessToken:[keys objectForKey:@"access_token"]];
        [VKSdk setHash:[keys objectForKey:@"hash"]];
        [VKSdk setVkID:[keys objectForKey:@"vk_id"]];
        [vkSdkInstance->_delegate VKSdkDidReceiveNewToken];
    }
    else {
        [vkSdkInstance->_delegate VKSdkTokenFail];
    }
}

#pragma mark Setters and getters

+ (void)setAccessToken:(NSString *)accessToken {
    vkSdkInstance->_accessToken = accessToken;
}

+ (NSString *)getAccessToken {
    return vkSdkInstance->_accessToken;
}

+ (void)setHash:(NSString *)hash {
    vkSdkInstance->_hash = hash;
}

+ (NSString *)getHash{
    return vkSdkInstance->_hash;
}

+ (void)setVkID:(NSString *)vkID {
    vkSdkInstance->_vkID = vkID;
}

+ (NSString *)getVkID {
    return vkSdkInstance->_vkID;
}

@end
