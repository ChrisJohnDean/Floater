//
//  FloaterObject.h
//  Floater
//
//  Created by Chris Dean on 2018-03-08.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FloaterObject : NSObject

@property (nonatomic) NSNumber *iD;
@property (nonatomic) NSString *blogName;
@property (nonatomic) NSMutableArray *tagsArray;
@property (nonatomic) NSMutableArray * floaterArray;

- (instancetype)initWithDict:(NSDictionary*)floater;


@end
