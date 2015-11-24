//
//  ViewController.m
//  EyeFinder
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
    
    imageProcessor = [[ImageProcessor alloc] initWithView:imageView];
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
