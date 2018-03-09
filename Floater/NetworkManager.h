//
//  NetworkManager.h
//  Floater
//
//  Created by Chris Dean on 2018-03-07.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetworkManager;
@protocol floaterDelegate <NSObject>

- (void)passFloaterArray:(NSMutableArray*)arrayOfFloaters;

@end


@interface NetworkManager : NSObject

@property (nonatomic, weak) id<floaterDelegate> delegate;
@property (nonatomic) NSMutableArray *arrayOfFloaters;

- (void)tumblrNetworkRequest:(NSString*)blogName withFloaterType:(NSString*)floaterType;

@end
