//
//  Collage Manager.h
//  Floater
//
//  Created by Tyson Parks on 3/8/18.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Collage_Manager : NSObject

@property (nonatomic, strong) NSString *canvasName;
@property (nonatomic) CGRect *canvasFrame;
@property (nonatomic) NSUInteger floaterCount;


// MARK: Action methods
-(void)addFloaterToCanvas;

// MARK: Export methods
-(void)saveImage;

@end
