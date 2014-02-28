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
    [_buttonActivity startAnimating];
    [WinkMeAPI likeUserWithID:_friendID andCompletionBlock:^(NSData *result, NSError *error) {
        NSLog(@"Data: %@", result);
        [_buttonActivity stopAnimating];
        button.hidden = NO;
    }];
}

-(void)drawRect:(CGRect)rect {
    [_buttonActivity stopAnimating];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.friendPhoto.layer setCornerRadius:self.friendPhoto.frame.size.width / 2];
    [self.friendPhoto.layer setMasksToBounds:YES];
}

@end
