//
//  CanvasViewController.m
//  Floater
//
//  Created by Tyson Parks on 3/8/18.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "CanvasViewController.h"
#import "FloaterObject.h"

@interface CanvasViewController ()

@property (nonatomic, weak) UIView *canvasView;

@property (nonatomic, strong) NSArray<FloaterObject *> *floatrsArray;

-(void)setUpPaletteView;

@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    [UIView animateWithDuration:4 delay:0.0f options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState animations:^{self.view.backgroundColor = [UIColor redColor];} completion:nil];
//    self.view.backgroundColor = [UIColor redColor];
    
//    -(void)animateColorBack {
//
//    }

    UIView *canvasView = [[UIView alloc] init];
    canvasView.translatesAutoresizingMaskIntoConstraints = NO;
    canvasView.backgroundColor = [UIColor greenColor];
    canvasView.layer.cornerRadius = 10.0;
    [self.view addSubview:canvasView];
    
    [canvasView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor].active = YES;
    [canvasView.heightAnchor constraintEqualToAnchor:canvasView.widthAnchor].active = YES;
    [canvasView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor].active = YES;
    [canvasView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20.0].active = YES;
    
    self.floatrsArray = @[@1,@2,@3,@4];
    [self setUpPaletteView];
    
    
}


-(void)setUpPaletteView {
    CGFloat floatrOffset = 0;
    for (int i=0; i<4; i++) {
        UIView *floatrView = [[UIView alloc] init];
        floatrView.translatesAutoresizingMaskIntoConstraints = NO;
        floatrView.backgroundColor = [UIColor yellowColor];
        floatrView.layer.cornerRadius = 10.0;
        [self.view addSubview:floatrView];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
