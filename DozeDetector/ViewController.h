//
//  ViewController.h
//  DozeDetector
//
//  Created by Craig Thrall on 11/1/15.
//  Copyright © 2015 Craig Thrall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageProcessor.h"

@interface ViewController : UIViewController
{
    __weak IBOutlet UIImageView *imageView;
    ImageProcessor* imageProcessor;
}

@property (weak, nonatomic) IBOutlet UIButton *calibrateButton;
@property (weak, nonatomic) IBOutlet UIButton *detectButton;

@end
