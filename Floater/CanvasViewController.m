//
//  CanvasViewController.m
//  Floater
//
//  Created by Tyson Parks on 3/8/18.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "CanvasViewController.h"
#import "FloaterObject.h"
#import "Floater-Swift.h"
@import Realm;

@interface CanvasViewController () <UIGestureRecognizerDelegate>


@property (nonatomic, strong) UIView *canvasView;

@property (nonatomic, strong) NSArray<FloaterObject *> *floatrsArray;
@property (nonatomic, strong) NSMutableArray<UIView *> *palletteFloatrViewsArray;
@property (nonatomic, strong) NSMutableArray<UIView *> *canvasFloatrViewsArray;

@property (nonatomic) NSMutableArray *realmImageArray;

@property (nonatomic, strong) NSMutableSet *activeRecognizers;

-(void)setupPaletteView;

@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.palletteFloatrViewsArray = [NSMutableArray new];
    self.canvasFloatrViewsArray = [NSMutableArray new];
    self.floatrsArray = @[@1,@2,@3,@4];
    self.realmImageArray = [[NSMutableArray alloc] init];
    
    self.activeRecognizers = [NSMutableSet set];
    [self basicFetchandCompletionHandler:^{
        [self setupPaletteView];
    }];
     
    [self setupView];
    [self setupCanvasView];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (IBAction)SaveImage:(id)sender {
    [self saveCanvasImage];
}

- (void)basicFetchandCompletionHandler:(void(^)(void))completionHandler {
    @try {
        RLMResults<ImagePalette*> *results = [ImagePalette allObjects];
        for(ImagePalette *object in results) {
            
            UIImage *image = [UIImage imageWithData:object.data];
            [self.realmImageArray addObject:image];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    completionHandler();
}

-(void)setupView {
    // Animated background color
    self.view.backgroundColor = [UIColor blueColor];
    [UIView animateWithDuration:4 delay:0.0f options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{self.view.backgroundColor = [UIColor redColor];} completion:nil];
    
//    self.view.backgroundColor = [UIColor clearColor];
    
}

-(void)setupCanvasView {
    self.canvasView = [[UIView alloc] initWithFrame:CGRectZero];
    self.canvasView.translatesAutoresizingMaskIntoConstraints = NO;
    self.canvasView.backgroundColor = [UIColor clearColor];
    self.canvasView.layer.cornerRadius = 10.0;
    self.canvasView.layer.borderWidth = 5.0;
    self.canvasView.layer.borderColor = [[UIColor cyanColor] CGColor];
    [self.view addSubview:self.canvasView];
    
    [self.canvasView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor].active = YES;
    [self.canvasView.heightAnchor constraintEqualToAnchor:self.canvasView.widthAnchor].active = YES;
    [self.canvasView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor].active = YES;
    [self.canvasView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20.0].active = YES;
}

-(void)setupPaletteView {
    CGFloat floatrOffset = 0;
    
    for (int i=0; i<self.realmImageArray.count; i++) {
//        UIView *floatrView = [[UIView alloc] initWithFrame:CGRectZero];
        
        
        //UIImage *floatrImage = self.selectedImages[i];
        UIImage *floatrImage = self.realmImageArray[i];
        UIImageView *floatrView = [[UIImageView alloc]initWithImage:floatrImage];
        floatrView.translatesAutoresizingMaskIntoConstraints = NO;
        floatrView.backgroundColor = [UIColor clearColor];
        floatrView.layer.cornerRadius = 10.0;
        floatrView.userInteractionEnabled = YES;
        floatrView.contentMode =UIViewContentModeScaleAspectFit;
        [self.view addSubview:floatrView];
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pallettePanGestureRecognized:)];
        [floatrView addGestureRecognizer:panRecognizer];
        
        [self.palletteFloatrViewsArray addObject:floatrView];
        
        CGFloat floatrWidth = 75.0;
        CGFloat floatrCount = self.realmImageArray.count;
        CGFloat viewWidth = self.view.frame.size.width;
        CGFloat paletteSpacing = viewWidth / (floatrCount+1);
        floatrOffset += paletteSpacing;
        
        [floatrView.widthAnchor constraintEqualToConstant:floatrWidth].active = YES;
        [floatrView.heightAnchor constraintEqualToConstant:floatrWidth].active = YES;
        [floatrView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:floatrOffset].active = YES;
        [floatrView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-60.0].active = YES;
    }
}


-(void)pallettePanGestureRecognized: (UIPanGestureRecognizer*) recognizer {
    //    NSLog(@"Being touched!");
    
    CGPoint floatrLocation = [recognizer locationInView:self.view];
    recognizer.view.center = floatrLocation;
    CGPoint floatrLocationInCanvas = [recognizer locationInView:self.canvasView];
    UIImageView *castedView = (UIImageView *)recognizer.view;
    UIImage *imageToPass = castedView.image;
    
//    NSLog(@"%@", recognizer.view);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateEnded:
            
            if (CGRectContainsPoint(self.canvasView.frame, floatrLocation)) {
                // Create corresponding floatrView and add it to the canvasView
                [self setupFloatrInCanvasViewWithLocation:floatrLocationInCanvas andImage:imageToPass];
                [recognizer.view removeFromSuperview];
                // Option: Make pallette floatr disappear from main view (means floatr can only be used once)
                // or instantiate new floatrView at floatr origin (means multiple versions of same floatr can be used)
                //                [UIView animateWithDuration:2.0 animations:^{recognizer.view.layer.opacity = 0.0;}];
            }
            break;
        default:
            break;
    }
}

-(void)setupFloatrInCanvasViewWithLocation: (CGPoint) location andImage: (UIImage *) image {
    CGFloat floatrInitialWidth = 75.0;
    CGFloat floatrFinalWidth = 100.0;
    
    
    UIImageView *canvasFloatrView = [[UIImageView alloc] initWithImage:image];
    canvasFloatrView.frame = CGRectMake(0.0, 0.0, floatrInitialWidth, floatrInitialWidth);
    canvasFloatrView.center = location;
    canvasFloatrView.translatesAutoresizingMaskIntoConstraints = YES;
    canvasFloatrView.backgroundColor = [UIColor clearColor];
    canvasFloatrView.layer.cornerRadius = 10.0;
    canvasFloatrView.userInteractionEnabled = YES;
    canvasFloatrView.contentMode =UIViewContentModeScaleAspectFit;
    
    [self.canvasView addSubview:canvasFloatrView];
    
//    [UIView animateWithDuration:0.5 animations:^{canvasFloatrView.frame = CGRectMake(canvasFloatrView.frame.origin.x, canvasFloatrView.frame.origin.y, floatrFinalWidth, floatrFinalWidth);}];
    
    UIViewPropertyAnimator *expandSizeAnimation = [[UIViewPropertyAnimator alloc]initWithDuration:0.5 dampingRatio:.5 animations:^{canvasFloatrView.frame = CGRectMake(canvasFloatrView.frame.origin.x, canvasFloatrView.frame.origin.y, floatrFinalWidth, floatrFinalWidth);}];
    [expandSizeAnimation startAnimation];

    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleCanvasGestures:)];
    [canvasFloatrView addGestureRecognizer:panRecognizer];
    panRecognizer.delegate = self;
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handleCanvasGestures:)];
    [canvasFloatrView addGestureRecognizer:pinchRecognizer];
    pinchRecognizer.delegate = self;
    CGFloat scale = pinchRecognizer.scale;
    
    UIRotationGestureRecognizer *twoFingersRotateRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleCanvasGestures:)];
    [canvasFloatrView addGestureRecognizer:twoFingersRotateRecognizer];
    twoFingersRotateRecognizer.delegate = self;
    CGFloat rotation = twoFingersRotateRecognizer.rotation;
    
    
//    CGAffineTransform referenceTransform = canvasFloatrView.transform;
//    referenceTransform = CGAffineTransformScale(referenceTransform, scale, scale);
//    referenceTransform = CGAffineTransformRotate(referenceTransform, rotation);
//    canvasFloatrView.transform = referenceTransform;


    [self.canvasFloatrViewsArray addObject:canvasFloatrView];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handleCanvasGestures: (UIGestureRecognizer *) recognizer {
    CGPoint floatrLocation = [recognizer locationInView:self.canvasView];
    recognizer.view.center = floatrLocation;
//    UIImageView *castedView = (UIImageView *)recognizer.view;
    
//    CGAffineTransform transform = recognizer.view.transform
    CGAffineTransform referenceTransform = recognizer.view.transform;
//    referenceTransform = CGAffineTransformScale(referenceTransform, recognizer.scale, recognizer.scale);
//    referenceTransform = CGAffineTransformRotate(referenceTransform, rotation);
//    canvasFloatrView.transform = referenceTransform;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            if (self.activeRecognizers.count == 0)
                 referenceTransform = recognizer.view.transform;
            [self.activeRecognizers addObject:recognizer];
            break;

        case UIGestureRecognizerStateChanged: {
            CGAffineTransform transform = referenceTransform;
            for (UIGestureRecognizer *recognizer in self.activeRecognizers)
                transform = [self applyRecognizer:recognizer toTransform:transform];
            recognizer.view.transform = transform;
            break;
            
        case UIGestureRecognizerStateEnded:
            referenceTransform = [self applyRecognizer:recognizer toTransform:referenceTransform];
            [self.activeRecognizers removeObject:recognizer];
            break;
        }

        default:
            break;
    }

}



- (CGAffineTransform)applyRecognizer:(UIGestureRecognizer *)recognizer toTransform:(CGAffineTransform)transform
{
    if ([recognizer respondsToSelector:@selector(rotation)]) {
        CGFloat rotation = [(UIRotationGestureRecognizer *)recognizer rotation];
        [(UIRotationGestureRecognizer *)recognizer setRotation:0.0];
        return CGAffineTransformRotate(transform, rotation);
        
    }
    else if ([recognizer respondsToSelector:@selector(scale)]) {
        CGFloat scale = [(UIPinchGestureRecognizer *)recognizer scale];
        [(UIPinchGestureRecognizer *)recognizer setScale:1.0];
        return CGAffineTransformScale(transform, scale, scale);
        
    }
    else
        return transform;
}

-(void)saveCanvasImage {
//    NSLog(@"I'm trying to save this image!");
    [self requestAuthorizationWithRedirectionToSettings];
    UIView* captureView = self.canvasView;
    UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, NO, 0.0f);
    [captureView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *pngData = UIImagePNGRepresentation(screenshot);
    UIImage *pngImage = [UIImage imageWithData:pngData];
//    UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil);
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:@[pngImage] applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:true completion:nil];
    
    
}


- (void)requestAuthorizationWithRedirectionToSettings {
    dispatch_async(dispatch_get_main_queue(), ^{
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized)
        {
            //We have permission. Do whatever is needed
        }
        else
        {
            //No permission. Trying to normally request it
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status != PHAuthorizationStatusAuthorized)
                {
                    //User don't give us permission. Showing alert with redirection to settings
                    //Getting description string from info.plist file
                    NSString *accessDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSPhotoLibraryUsageDescription"];
                    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:accessDescription message:@"To give permissions tap on 'Change Settings' button" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
                    [alertController addAction:cancelAction];
                    
                    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Change Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication] openURL:UIApplicationOpenSettingsURLString options:nil completionHandler:nil];
                    }];
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//                }];
                    [alertController addAction:settingsAction];
                    
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
                }
            }];
        }
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
