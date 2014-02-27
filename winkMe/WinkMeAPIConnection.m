//
//  WinkMeAPIConnection.m
//  winkMe
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 AKorenev. All rights reserved.
//

#import "WinkMeAPIConnection.h"

static NSMutableArray *sharedConnectionList = nil;

@implementation WinkMeAPIConnection
@synthesize request, completionBlock;

- (id)initWithReuest:(NSURLRequest *)req {
    self = [super init];
    if (self) {
        [self setRequest:req];
    }
    return self;
}

- (void)start {
    container = [[NSMutableData alloc] init];
    internalConnection = [[NSURLConnection alloc] initWithRequest:request
                                                         delegate:self
                                                 startImmediately:YES];
    
    if (!sharedConnectionList) {
        sharedConnectionList = [[NSMutableArray alloc] init];
    }
    
    [sharedConnectionList addObject:self];
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [container appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([self completionBlock]) {
        [self completionBlock](container, nil);
    }
    
    [sharedConnectionList removeObject:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if ([self completionBlock]) {
        [self completionBlock](nil, error);
    }
    
    [sharedConnectionList removeObject:self];
}

@end
