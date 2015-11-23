//
//  ImageProcessor.h
//  EyeFinder
//
//  Created by Craig Thrall on 11/21/15.
//  Copyright © 2015 Craig Thrall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/objdetect/objdetect.hpp>
#import <opencv2/videoio/cap_ios.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "SpeechAlert.h"

using namespace cv;

const NSTimeInterval samplePeriod = 1;
const int minSampleCount = 3;

@interface ImageProcessor : CvVideoCamera<CvVideoCameraDelegate>
{
    CascadeClassifier faceCascade;
    CascadeClassifier eyeCascade;
    std::vector<cv::Rect> faces;
    std::vector<cv::Rect> eyes;
    
    CFTimeInterval startTime;
    uint32_t eyeAccum;
    uint32_t sampleCount;
    float percentOpen;
    
    bool calibrated;
}

-(id)initWithView:(UIImageView*) imageView;
-(void)calibrate;
-(void)detect;
-(void) processImage:(Mat&) image;

@property (nonatomic, retain) CvVideoCamera* videoCamera;
@property (nonatomic, retain) SpeechAlert* speechAlert;

@end