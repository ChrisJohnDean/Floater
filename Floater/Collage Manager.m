//
//  Collage Manager.m
//  Floater
//
//  Created by Tyson Parks on 3/8/18.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "Collage Manager.h"
#import "Canvas.h"

@interface Collage_Manager()


// MARK: Object initializer methods
-(void)setupCanvas;
-(void)setupPalette;


@end

@implementation Collage_Manager


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)setupCanvas; {
    Canvas *canvas = [Canvas new];
}

-(void)setupPalette {
    
}





-(void)saveImage {
    //save that image!
}


@end
