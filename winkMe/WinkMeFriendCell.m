//
//  WinkMeFriendCell.m
//  winkMe
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "WinkMeFriendCell.h"
#import "WinkMeAPI.h"

@implementation WinkMeFriendCell

- (IBAction)tapLikeButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.hidden = YES;
    [WinkMeAPI likeUserWithID:_friendID andCompletionBlock:^(NSData *result, NSError *error) {
        NSLog(@"Data: %@", result);
        button.hidden = NO;
    }];
}

@end
