//
//  CollectionViewController.m
//  Floater
//
//  Created by Chris Dean on 2018-03-08.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "CollectionViewController.h"
#import "FloaterObject.h"
#import "Floater-Swift.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageManager.h"
#import "CanvasViewController.h"
@import Realm;
@import Gifu;


@interface CollectionViewController() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic) NSArray *arrayOfFloaters;
@property (nonatomic) NSCache *floaterCache;
@property (nonatomic) NSMutableArray *selectedRows;
@property (nonatomic) ImageManager *imageManager;
@property (nonatomic) NSMutableArray *arrayOfData;


@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageManager = [[ImageManager alloc] init];
    self.arrayOfFloaters = [[NSArray alloc] init];
    self.selectedRows = [[NSMutableArray alloc] init];
    self.arrayOfData = [[NSMutableArray alloc] init];
    
    NetworkManager *networkManager = [[NetworkManager alloc] init];
    networkManager.delegate = self;
    [networkManager tumblrNetworkRequest:self.blogName withFloaterType:self.floaterType];

    
}

- (void)populatePaletteInDB {
    
    for(NSData *data in self.arrayOfData) {
        ImagePalette *imagePalette = [self createPaletteWithData:data];
        @try {
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                [realm addObject:imagePalette];
            }];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception.reason);
        }
    }
}

- (ImagePalette*)createPaletteWithData:(NSData*)data {
    ImagePalette *imagePalette = [[ImagePalette alloc] init];
    imagePalette.data = data;
    return imagePalette;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.myCollectionView.backgroundColor = [UIColor lightGrayColor];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// floaterDelegate protocol method
- (void)passFloaterArray:(NSMutableArray *)arrayOfFloaters {
    self.arrayOfFloaters = arrayOfFloaters;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.myCollectionView reloadData];

    });

}

//// Pass array of selected images to canvasVC
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showCanvas"]) {

        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteAllObjects];
        [realm commitWriteTransaction];
        [self populatePaletteInDB];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayOfFloaters.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FloaterCollectionViewCell *floaterCell = [self.myCollectionView dequeueReusableCellWithReuseIdentifier:@"floaterCell" forIndexPath:indexPath];
    FloaterObject *floater = self.arrayOfFloaters[indexPath.row];
    NSArray *floaterArray = floater.floaterArray;
    NSDictionary *smallImageDict = floaterArray[floaterArray.count-2];
    NSString *urlString = smallImageDict[@"url"];
    
    if([self.floaterCache objectForKey:urlString]) {
        
        UIImage *cachedImage = [self.floaterCache objectForKey:urlString];
        dispatch_async(dispatch_get_main_queue(), ^{
            floaterCell.floaterView.image = cachedImage;
        });
    } else {
        NSURL *url = [NSURL URLWithString:urlString];
        floaterCell.downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(error) {
                NSLog(@"error: %@", error.localizedDescription);
                return;
            }
            
            NSData *data = [NSData dataWithContentsOfURL:location];
            UIImage *image = [UIImage imageWithData:data];
            
            // Adds UIImage to floaterCache with urlString as key
            [self.floaterCache setObject:image forKey:urlString];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                floaterCell.floaterView.image = image;
            });
            
//            if([self.floaterType  isEqualToString:(@"animated")]) {
//                GifManager *gifManager = [[GifManager alloc] init];
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [gifManager gifLoaderWithFrame:floaterCell.frame];
//                    [gifManager gifAnimatorWithData:data];
//                    floaterCell.floaterView = gifManager.imageView;
//                });
            
            
            
            
            
        }];
        
        [floaterCell.downloadTask resume];
    }
    return floaterCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    NSString *rowString = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    
    if([self.selectedRows containsObject:rowString]) {
        cell.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        NSInteger index = [self.selectedRows indexOfObject:rowString];
        [self.selectedRows removeObjectAtIndex:index];
        [self.arrayOfData removeObjectAtIndex:index];
    } else {
        [self.selectedRows addObject:rowString];
        FloaterObject *floater = [self.arrayOfFloaters objectAtIndex:indexPath.row];
        [self.imageManager imageDownload:floater andCompletionHandler:^(NSData *data, UIImage *image) {
            [self.arrayOfData addObject:data];
        }];
        
        
        cell.layer.borderWidth = 3;
        cell.layer.borderColor = [[UIColor cyanColor] CGColor];
        cell.layer.cornerRadius = 6;
    }
    
}


@end





