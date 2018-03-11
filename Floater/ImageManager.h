//
//  ImageManager.h
//  Floater
//
//  Created by Chris Dean on 2018-03-09.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FloaterObject.h"

@interface ImageManager : NSObject

- (void)imageDownload:(FloaterObject*)floater andCompletionHandler:(void(^)(NSData *data, UIImage *image))completionHandler;

@end
