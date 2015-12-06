//
//  ViewController.m
//  DozeDetector
//
//  Created by Craig Thrall on 11/1/15.
//  Copyright © 2015 Craig Thrall. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleButton: self.calibrateButton];
    [self styleButton: self.detectButton];
    imageProcessor = [[ImageProcessor alloc] initWithView:imageView];
}

- (void)styleButton:(UIButton*)button {
    [[button layer] setBorderWidth:2.0f];
    [button setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
    [[button layer] setBorderColor:[UIColor blueColor].CGColor];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(id)sender {
    [imageProcessor detect];
}

- (IBAction)calibrateClick:(id)sender {
    [imageProcessor calibrate];
}

@end
