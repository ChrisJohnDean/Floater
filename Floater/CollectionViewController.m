//
//  CollectionViewController.m
//  Floater
//
//  Created by Chris Dean on 2018-03-08.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "CollectionViewController.h"
#import "FloaterObject.h"

@interface CollectionViewController()

@property (nonatomic) NSArray *arrayOfFloaters;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NetworkManager *networkManager = [[NetworkManager alloc] init];
    networkManager.delegate = self;
    [networkManager tumblrNetworkRequest:self.blogName withFloaterType:self.floaterType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)passFloaterArray:(NSMutableArray *)arrayOfFloaters {
    self.arrayOfFloaters = arrayOfFloaters;
    for(FloaterObject *floater in self.arrayOfFloaters) {
        NSLog(floater.blogName);
    }
}

@end
