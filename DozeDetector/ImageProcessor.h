//
//  ImageProcessor.h
//  DozeDetector
//
//  Created by Craig Thrall on 11/21/15.
//  Copyright © 2015 Craig Thrall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/objdetect/objdetect.hpp>
#import <opencv2/videoio/cap_ios.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "SpeechAlert.h"

using namespace cv;

const NSTimeInterval samplePeriod = 1;
const int minSampleCount = 3;

@interface EyeDetector : NSObject
{
    CascadeClassifier eyeCascade;
    Scalar highlightColor;
}

-(id) initWithCascade:(NSString*) cascadeName withColor:(const Scalar&)initColor;
-(int) processImage:(Mat&) image forFaces:(std::vector<cv::Rect>&)faces;
@end

@interface ImageProcessor : CvVideoCamera<CvVideoCameraDelegate>
{
    CascadeClassifier faceCascade;
    CascadeClassifier eyeCascade;
    
    std::vector<std::string> eyeClassifierFilenames;
    std::vector<CascadeClassifier> eyeClassifiers;
    
    std::vector<cv::Rect> faces;
    
    EyeDetector* eyeDetector;
    EyeDetector* eyeDetector2;
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
-(void)processImage:(Mat&) image;

@property (nonatomic, retain) CvVideoCamera* videoCamera;
@property (nonatomic, retain) SpeechAlert* speechAlert;

@end