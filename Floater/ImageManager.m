//
//  ImageManager.m
//  Floater
//
//  Created by Chris Dean on 2018-03-09.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager

- (void)imageDownload:(FloaterObject*)floater {
    
    NSArray *floaterArray = floater.floaterArray;
    NSDictionary *originalImageDict = floaterArray.firstObject;
    NSString *urlString = originalImageDict[@"url"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        
    }];
   [downloadTask resume];
}

@end
