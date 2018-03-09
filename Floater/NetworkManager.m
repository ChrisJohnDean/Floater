//
//  NetworkManager.m
//  Floater
//
//  Created by Chris Dean on 2018-03-07.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "NetworkManager.h"
#import "FloaterObject.h"

@interface NetworkManager()

@property (nonatomic) NSString *const apiKey;

@end

@implementation NetworkManager


- (void)tumblrNetworkRequest:(NSString*)blogName withFloaterType:(NSString*)floaterType {
    
     self.apiKey = @"A0ZPE7EUBZQbZY9iOBlpOedx09Q0VZwSt7rTzpwlm2ogYRyU8p";
    // Make network request to Tumblr with input from
    NSString *urlString = [NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/posts/photo?api_key=%@&tag=%@", blogName, self.apiKey, floaterType];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            return;
        }
        [self parseResponseData:data];
    }];
    [dataTask resume];
}



- (void)parseResponseData:(NSData*)data {
    
    NSError *error = nil;
    
    // Grab initial JSON object from Tumblr
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if(error != nil) {
        NSLog(@"%@", error);
        return;
    }
    
    // Parse JSON data to get an array of "post" objects from Tumblr
    NSDictionary *responsDict = jsonObject[@"response"];
    NSArray *postsArray = responsDict[@"posts"];
    
    // Initialize array that will contain Floater objects
    self.arrayOfFloaters = [[NSMutableArray alloc] init];
    
    // Instanctiate a FloaterObject for every photo post from retrieved tumblr JSON dictionaries
    for(NSDictionary *dict in postsArray) {
        FloaterObject *floater = [[FloaterObject alloc] initWithDict:dict];
        [self.arrayOfFloaters addObject:floater];
        NSString *floaterName = [NSString stringWithFormat:@"%@", floater.blogName];
        NSLog(floaterName);
    }

    // Pass array of FloaterObjects to self.delegate
    [self.delegate passFloaterArray:self.arrayOfFloaters];
}

@end
