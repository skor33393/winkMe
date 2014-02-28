//
//  WinkMeFriendCell.h
//  winkMe
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKSdk.h"

@interface WinkMeFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *friendPhoto;
@property (weak, nonatomic) IBOutlet UILabel *friendName;
@property(strong, nonatomic) NSString *friendID;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *buttonActivity;
@end
