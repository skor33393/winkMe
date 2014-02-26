//
//  WinkMeFriendsListViewController.h
//  winkMe
//
//  Created by Admin on 25.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKSdk.h"

@interface WinkMeFriendsListViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *friends;

@end
