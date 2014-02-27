//
//  WinkMeFriendsListViewController.m
//  winkMe
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "WinkMeFriendsListViewController.h"
#import "VKSdk.h"

@interface WinkMeFriendsListViewController ()

@property(nonatomic, strong) NSArray *friendsList;

@end

@implementation WinkMeFriendsListViewController

- (void)loadFriends {
    UIView *activityView = [[UIView alloc] initWithFrame:self.view.frame];
    [activityView setBackgroundColor:[UIColor lightGrayColor]];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = activityView.center;
    
    [activityView addSubview:activityIndicator];
    
    [self.view addSubview:activityView];
    [activityIndicator startAnimating];
    
    NSString *requestString = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?"
                               "uid=%@&fields=first_name,last_name,photo", [VKSdk getVkID]];
    
    NSURL *url = [NSURL URLWithString:requestString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (jsonObject != nil && error == nil) {
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                _friendsList = [jsonObject objectForKey:@"response"];
                [activityView removeFromSuperview];
                [self.friendsTableView reloadData];
            }
        }
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
    cell.friendName.text = [user objectForKey:@"first_name"];
    
    return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
