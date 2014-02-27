//
//  WinkMeFriendCell.m
//  winkMe
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "WinkMeFriendCell.h"

@implementation WinkMeFriendCell

- (IBAction)tapLikeButton:(id)sender {
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"vk_id\":%@, \"hash\":\"%@\", \"honey_vk_id\":%@} ", [VKSdk getVkID], [VKSdk getHash], [self friendID]];
    NSLog(@"Request: %@", jsonRequest);
    
    NSURL *url = [NSURL URLWithString:@"http://www.innocraft.net/addHoney"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSMutableData *d = [NSMutableData data];
    [d appendData:data];
    
    NSString *a = [[NSString alloc] initWithData:d encoding:NSASCIIStringEncoding];
    
    NSLog(@"Data: %@", a);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
