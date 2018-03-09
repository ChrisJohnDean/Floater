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


-(void)setupView {
    self.view.backgroundColor = [UIColor blueColor];
    [UIView animateWithDuration:4 delay:0.0f options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{self.view.backgroundColor = [UIColor redColor];} completion:nil];
}

-(void)setupCanvasView {
    self.canvasView = [[UIView alloc] initWithFrame:CGRectZero];
    self.canvasView.translatesAutoresizingMaskIntoConstraints = NO;
    self.canvasView.backgroundColor = [UIColor greenColor];
    self.canvasView.layer.cornerRadius = 10.0;
    [self.view addSubview:self.canvasView];
    
    [self.canvasView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor].active = YES;
    [self.canvasView.heightAnchor constraintEqualToAnchor:self.canvasView.widthAnchor].active = YES;
    [self.canvasView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor].active = YES;
    [self.canvasView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20.0].active = YES;
}

-(void)setupPaletteView {
    CGFloat floatrOffset = 0;
    for (int i=0; i<4; i++) {
        UIView *floatrView = [[UIView alloc] init];
        floatrView.translatesAutoresizingMaskIntoConstraints = NO;
        floatrView.backgroundColor = [UIColor yellowColor];
        floatrView.layer.cornerRadius = 10.0;
        floatrView.userInteractionEnabled = YES;
        [self.view addSubview:floatrView];
        
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
        [floatrView addGestureRecognizer:panRecognizer];
        
        [self.palletteFloatrViewsArray addObject:floatrView];
        
        CGFloat floatrWidth = 55.0;
        CGFloat floatrCount = 5;
        CGFloat viewWidth = self.view.frame.size.width;
        CGFloat paletteSpacing = viewWidth / floatrCount;
        floatrOffset += paletteSpacing;
        
        [floatrView.widthAnchor constraintEqualToConstant:floatrWidth].active = YES;
        [floatrView.heightAnchor constraintEqualToConstant:floatrWidth].active = YES;
        [floatrView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:floatrOffset].active = YES;
        [floatrView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-40.0].active = YES;
    }
}


-(void)panGestureRecognized: (UIPanGestureRecognizer*) recognizer {
//    NSLog(@"Being touched!");
    
    CGPoint floatrLocation = [recognizer locationInView:self.view];
    recognizer.view.center = floatrLocation;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateEnded:
            
            if (CGRectContainsPoint(self.canvasView.frame, floatrLocation)) {
                NSLog(@"Hey, I'm in the canvas!");
                // Create corresponding floatrView and add it to the canvasView
                
                // Option: Make pallette floatr disappear from main view (means floatr can only be used once)
                // or instantiate new floatrView at floatr origin (means multiple versions of same floatr can be used)
                [UIView animateWithDuration:2.0 animations:^{recognizer.view.layer.opacity = 0.0;}];
                
            }
    
            break;
            
        default:
            break;
    }
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
