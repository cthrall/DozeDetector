//
//  ViewController.m
//  EyeFinder
//
//  Created by Craig Thrall on 11/1/15.
//  Copyright © 2015 Craig Thrall. All rights reserved.
//

#import <opencv2/highgui/highgui.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello!" message:@"Welcome" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    [alert show];*/
    
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    
    NSString* facePath = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_alt2" ofType:@"xml"];
    NSString* eyePath = [[NSBundle mainBundle] pathForResource:@"haarcascade_eye" ofType:@"xml"];
    
    faceCascade.load([facePath UTF8String]);
    eyeCascade.load([eyePath UTF8String]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(id)sender {
    [self.videoCamera start];
}

// TODO: add "Calibrate" button, rename "Button" to "Detect"
// TODO: add number of eyes on screen
// TODO: show alert
// TODO: filter eye count

#ifdef __cplusplus
- (void) processImage:(Mat&) image
{
    float haarScale = 1.3;
    cv::Size minSize = cvSize(30, 30);
    int minNeighbors = 2;
    int haarFlags = 0 | CV_HAAR_DO_CANNY_PRUNING;
    // int haarFlags = 0 | CV_HAAR_SCALE_IMAGE
    
    faceCascade.detectMultiScale(image, faces, haarScale, minNeighbors, haarFlags, minSize);
    NSLog(@"Found %d faces", faces.size());
    
    for (int i = 0; i < faces.size(); i++) {
        eyeCascade.detectMultiScale(image(faces[i]), eyes, haarScale, 2, haarFlags, cvSize(20, 20));
    }
    NSLog(@"Found %d eyes", eyes.size());
}
#endif

@end
