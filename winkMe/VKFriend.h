//
//  VKFriend.h
//  winkMe
//
//  Created by Admin on 28.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKFriend : NSObject

@property (nonatomic, copy) NSString *vkID;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *photoURL;
@property (nonatomic, strong) UIImage *photo;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
