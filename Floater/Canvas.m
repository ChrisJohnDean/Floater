//
//  Canvas.m
//  Floater
//
//  Created by Tyson Parks on 3/8/18.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas

-(instancetype)initWithName:(NSString *)name andFrame:(CGRect)frame {
self = [super init];
if (self) {
    _canvasName = name;
    _canvasFrame = &frame;
    
}
return self;
}






@end
