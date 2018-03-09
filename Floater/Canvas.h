//
//  Canvas.h
//  Floater
//
//  Created by Tyson Parks on 3/8/18.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

//#import <Foundation/Foundation.h>
@import UIKit;

@interface Canvas : NSObject

@property (strong, nonatomic) NSString *canvasName;
@property (nonatomic) CGRect *canvasFrame;

-(instancetype)initWithName:(NSString *) name andFrame:(CGRect) frame;

@end
