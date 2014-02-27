//
//  WinkMeFriendsListViewController.m
//  winkMe
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "WinkMeFriendsListViewController.h"
#import "VKSdk.h"
#import "VKFriendsStorage.h"

@interface WinkMeFriendsListViewController ()

@property(nonatomic, strong) NSArray *friendsList;

@end

@implementation WinkMeFriendsListViewController

- (void)loadFriends {
    //preparing Activity Views
    UIView *activityView = [[UIView alloc] initWithFrame:self.view.frame];
    [activityView setBackgroundColor:[UIColor lightGrayColor]];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = activityView.center;
    
    [activityView addSubview:activityIndicator];
    
    [self.view addSubview:activityView];
    [activityIndicator startAnimating];
    
    //sending request
    [[VKFriendsStorage sharedStorage] fetchFriendsWithCompletion:^(NSArray *friends, NSError *error) {
        _friendsList = friends;
        [activityView removeFromSuperview];
        [_friendsTableView reloadData];
    }];
}

#pragma mark UITableViewDataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_friendsList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WinkMeFriendCell *cell = (WinkMeFriendCell *)[tableView dequeueReusableCellWithIdentifier:@"friend"];
    
    NSDictionary *user = [_friendsList objectAtIndex:indexPath.row];
    
    cell.friendID = [user objectForKey:@"uid"];
    
    NSString *userName = [NSString stringWithFormat:@"%@ %@", [user objectForKey:@"first_name"], [user objectForKey:@"last_name"]];
    cell.friendName.text = userName;
    
    return cell;
}

#pragma mark UIViewController lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.friendsTableView.dataSource = self;
    
    [self loadFriends];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
