//
//  CanvasViewController.m
//  Floater
//
//  Created by Tyson Parks on 3/8/18.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "CanvasViewController.h"
#import "FloaterObject.h"

@interface CanvasViewController () <UIGestureRecognizerDelegate>


@property (nonatomic, strong) UIView *canvasView;

@property (nonatomic, strong) NSArray<FloaterObject *> *floatrsArray;
@property (nonatomic, strong) NSMutableArray<UIView *> *palletteFloatrViewsArray;
@property (nonatomic, strong) NSMutableArray<UIView *> *canvasFloatrViewsArray;

-(void)setupPaletteView;

@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.palletteFloatrViewsArray = [NSMutableArray new];
    self.canvasFloatrViewsArray = [NSMutableArray new];
    self.floatrsArray = @[@1,@2,@3,@4];
    
    
    [self setupView];
    [self setupCanvasView];
    [self setupPaletteView];
    
}

- (IBAction)SaveImage:(id)sender {
    [self saveCanvasImage];
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
    for (int i=0; i<self.selectedImages.count; i++) {
//        UIView *floatrView = [[UIView alloc] initWithFrame:CGRectZero];
        
        
        UIImage *floatrImage = self.selectedImages[i];
        UIImageView *floatrView = [[UIImageView alloc]initWithImage:floatrImage];
        floatrView.translatesAutoresizingMaskIntoConstraints = NO;
        floatrView.backgroundColor = [UIColor clearColor];
        floatrView.layer.cornerRadius = 10.0;
        floatrView.userInteractionEnabled = YES;
        floatrView.contentMode =UIViewContentModeScaleAspectFit;
        [self.view addSubview:floatrView];
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
        [floatrView addGestureRecognizer:panRecognizer];
        
        [self.palletteFloatrViewsArray addObject:floatrView];
        
        CGFloat floatrWidth = 75.0;
        CGFloat floatrCount = self.selectedImages.count;
        CGFloat viewWidth = self.view.frame.size.width;
        CGFloat paletteSpacing = viewWidth / (floatrCount+1);
        floatrOffset += paletteSpacing;
        
        [floatrView.widthAnchor constraintEqualToConstant:floatrWidth].active = YES;
        [floatrView.heightAnchor constraintEqualToConstant:floatrWidth].active = YES;
        [floatrView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:floatrOffset].active = YES;
        [floatrView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-60.0].active = YES;
    }
}


-(void)panGestureRecognized: (UIPanGestureRecognizer*) recognizer {
    //    NSLog(@"Being touched!");
    
    CGPoint floatrLocation = [recognizer locationInView:self.view];
    recognizer.view.center = floatrLocation;
    CGPoint floatrLocationInCanvas = [recognizer locationInView:self.canvasView];
    UIImageView *testView = (UIImageView *)recognizer.view;
    UIImage *imageToPass = testView.image;
    
    NSLog(@"%@", recognizer.view);
    
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
    CGFloat floatrWidth = 75.0;
    
    
    UIImageView *canvasFloatrView = [[UIImageView alloc] initWithImage:image];
    canvasFloatrView.frame = CGRectMake(0.0, 0.0, floatrWidth, floatrWidth);
    canvasFloatrView.center = location;
    canvasFloatrView.translatesAutoresizingMaskIntoConstraints = YES;
    canvasFloatrView.backgroundColor = [UIColor clearColor];
    canvasFloatrView.layer.cornerRadius = 10.0;
    canvasFloatrView.userInteractionEnabled = YES;
    
    [self.canvasView addSubview:canvasFloatrView];
    
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(canvasPanGestureRecognized:)];
    [canvasFloatrView addGestureRecognizer:panRecognizer];
    
    [self.canvasFloatrViewsArray addObject:canvasFloatrView];
}

-(void)canvasPanGestureRecognized: (UIPanGestureRecognizer *) recognizer {
    CGPoint floatrLocation = [recognizer locationInView:self.canvasView];
    recognizer.view.center = floatrLocation;
}

-(void)saveCanvasImage {
    NSLog(@"I'm trying to save this image!");
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
