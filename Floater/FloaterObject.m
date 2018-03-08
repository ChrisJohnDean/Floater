//
//  FloaterObject.m
//  Floater
//
//  Created by Chris Dean on 2018-03-08.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "FloaterObject.h"

@implementation FloaterObject

- (instancetype)initWithDict:(NSDictionary*)floater {
    self = [super init];
    if (self) {
        NSArray *photosArray = floater[@"photos"];
        NSDictionary *initialDict = photosArray[0];
        
        
        _blogName = floater[@"blog_name"];
        _iD = floater[@"id"];
        _tagsArray = floater[@"tags"];
        _floaterArray = initialDict[@"alt_sizes"];
    }
    return self;
}

@end
 
