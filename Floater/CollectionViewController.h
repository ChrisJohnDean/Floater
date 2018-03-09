//
//  CollectionViewController.h
//  Floater
//
//  Created by Chris Dean on 2018-03-08.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NetworkManager.h"

@interface CollectionViewController : UIViewController <floaterDelegate>

@property (nonatomic) NSString *blogName;
@property (nonatomic) NSString *floaterType;

@end
