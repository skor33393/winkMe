//
//  VKPhotoDownloader.h
//  winkMe
//
//  Created by Admin on 28.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VKFriend;

@interface VKPhotoDownloader : NSObject

@property (nonatomic, strong) VKFriend *user;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;

@end
