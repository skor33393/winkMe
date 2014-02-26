//
//  WinkMeViewController.m
//  winkMe
//
//  Created by Admin on 24.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "WinkMeViewController.h"
#import "WinkMeFriendsListViewController.h"

@interface WinkMeViewController ()

@end

@implementation WinkMeViewController

- (IBAction)authViaVK:(id)sender {
    [VKSdk authWithClientID:@"4184047" andScope:@"8195" andRedirectURI:@"http://www.innocraft.net/auth/winkme://"];
}

- (void)VKSdkDidReceiveNewToken {
    [self performSegueWithIdentifier:@"successfull auth" sender:self];
}

-(void)VKSdkTokenFail {
    
}

#pragma mark View controller lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [VKSdk inithWithDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
