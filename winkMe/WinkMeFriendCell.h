//
//  WinkMeFriendCell.h
//  winkMe
//
//  Created by Admin on 25.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WinkMeFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *friendPhoto;
@property (weak, nonatomic) IBOutlet UILabel *friendName;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) NSString *friendID;
@end
