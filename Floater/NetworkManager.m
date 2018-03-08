//
//  NetworkManager.m
//  Floater
//
//  Created by Chris Dean on 2018-03-07.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

- (void)tumblrNetworkRequest:(NSString*)blogName withFloaterType:(NSString*)floaterType {
    
    // Make network request to Tumblr with input from
    NSString *urlString = [NSString stringWithFormat:@"api.tumblr.com/v2/blog/%@/posts/photo?api_key={key}&tage=%@", blogName, floaterType];
    
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
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if(error != nil) {
        NSLog(@"%@", error);
        return;
    }
//    self.yelpCafeDict = jsonObject;
//
//    //Initialize array that will hold JSON objects grabbed from yelp
//    NSArray *cafeArray = self.yelpCafeDict[@"businesses"];
//
//    //Initialize array that will hold cafe objects
//    self.arrayOfCafes = [[NSMutableArray alloc] init];
//
//    //Parse JSON dictionars, create cafe objects, and add cafe objects to self.arrayOfCafes
//    for(NSDictionary *dict in cafeArray) {
//        Cafe *cafe = [[Cafe alloc] initWithDict:dict];
//        [self.arrayOfCafes addObject:cafe];
//    }
//
//    //Pass array of cafe objects to self.delegate(the ViewController object)
//    [self.delegate passCafesArray:self.arrayOfCafes];
}

@end
