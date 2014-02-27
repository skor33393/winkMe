//
//  WinkMeFriendsListViewController.h
//  winkMe
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinkMeFriendCell.h"

@interface WinkMeFriendsListViewController : UIViewController <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;
@end
