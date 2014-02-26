//
//  WinkMeFriendsListViewController.m
//  winkMe
//
//  Created by Admin on 25.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "WinkMeFriendsListViewController.h"
#import "WinkMeFriendCell.h"

@interface WinkMeFriendsListViewController ()

@property (strong, nonatomic) IBOutlet UITableView *friendsList;

@end

@implementation WinkMeFriendsListViewController

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    
    return [_friends count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WinkMeFriendCell *cell = nil;
    
    cell = (WinkMeFriendCell *)[self.tableView dequeueReusableCellWithIdentifier:@"friendCell" forIndexPath:indexPath];
    
    NSDictionary *user = [_friends objectAtIndex:indexPath.row];
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", [user objectForKey:@"first_name"], [user objectForKey:@"last_name"]];
    
    cell.friendName.text = fullName;
    cell.friendID = [user objectForKey:@"uid"];
    
    return cell;
}

- (void)loadFriendsList {
    NSLog(@"load friends list");
    
    NSString *requestString = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?"
                               "uid=%@&fields=uid,first_name,last_name,photo", [VKSdk getVkID]];
    
    NSURL *url = [NSURL URLWithString:requestString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSError *jsonError = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    if (jsonObject != nil && error == nil) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            _friends = [jsonObject objectForKey:@"response"];
        }
    }
    
    //NSLog(@"%@", _friends);
    
    /*NSOperationQueue *queue = [[NSOperationQueue alloc] init];
     [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
     NSError *error = nil;
     id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
     if (jsonObject != nil && error == nil) {
     if ([jsonObject isKindOfClass:[NSDictionary class]]) {
     friends = [jsonObject objectForKey:@"response"];
     }
     }
     }];*/

}

#pragma mark View controller lifecycle

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
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.contentInset = UIEdgeInsetsMake(CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]), 0., CGRectGetHeight(self.tabBarController.tabBar.frame), 0);
    
    [self loadFriendsList];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
