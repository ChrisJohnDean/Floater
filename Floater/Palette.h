//
//  Palette.h
//  Floater
//
//  Created by Tyson Parks on 3/8/18.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "FloaterObject.h"

@interface Palette : NSObject

@property (strong, nonatomic) NSArray<FloaterObject *> *floatersArray;
@property (nonatomic) NSArray *floaterGuides;


@end
