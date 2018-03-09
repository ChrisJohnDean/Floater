//
//  CanvasViewController.m
//  Floater
//
//  Created by Tyson Parks on 3/8/18.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()

@property (nonatomic, weak) UIView *canvasView;

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
    [self.view addSubview:canvasView];
    
    [canvasView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor].active = YES;
    [canvasView.heightAnchor constraintEqualToAnchor:canvasView.widthAnchor].active = YES;
    [canvasView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor].active = YES;
    [canvasView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20.0].active = YES;
    
    
}


-(void)setUpPaletteView {
    
    UIView *floatrView = [[UIView alloc] init];
    floatrView.translatesAutoresizingMaskIntoConstraints = NO;
    floatrView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:canvasView];
    
    CGFloat
    
    [floatrView.widthAnchor constraintEqualToConstant:<#(CGFloat)#>].active = YES;
    [floatrView.heightAnchor constraintEqualToAnchor:canvasView.widthAnchor].active = YES;
    [floatrView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor].active = YES;
    [floatrView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20.0].active = YES;
    
    
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
