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
#import "VKFriend.h"
#import "VKPhotoDownloader.h"

@interface WinkMeFriendsListViewController ()

@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
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
    
    VKFriend *user = [_friendsList objectAtIndex:indexPath.row];
    
    cell.friendID = user.vkID;
    cell.friendName.text = user.fullName;
    
    if (!user.photo) {
        [self startPhotoDownload:user forIndexPath:indexPath];
        cell.friendPhoto.image = [UIImage imageNamed:@"Placeholder.png"];
    }
    else {
        cell.friendPhoto.image = user.photo;
    }
    
    return cell;
}

#pragma mark Photo Downloading

- (void)startPhotoDownload:(VKFriend *)user forIndexPath:(NSIndexPath *)indexPath {
    VKPhotoDownloader *photoDownloader = [self.imageDownloadsInProgress objectForKey:indexPath];
    if (photoDownloader == nil)
    {
        photoDownloader = [[VKPhotoDownloader alloc] init];
        photoDownloader.user = user;
        [photoDownloader setCompletionHandler:^{
            
            WinkMeFriendCell *cell = (WinkMeFriendCell *)[self.friendsTableView cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.friendPhoto.image = user.photo;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        [self.imageDownloadsInProgress setObject:photoDownloader forKey:indexPath];
        [photoDownloader startDownload];
    }
}

#pragma mark UIViewController lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //make tab bar not to cover last cell in table view
    self.edgesForExtendedLayout = UIRectEdgeAll;
    NSInteger sbh = [[UIApplication sharedApplication] statusBarFrame].size.height;
    self.friendsTableView.contentInset = UIEdgeInsetsMake(sbh, 0., CGRectGetHeight(self.tabBarController.tabBar.frame), 0);
    
    //assign sata source
    self.friendsTableView.dataSource = self;
    
    [self loadFriends];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
