//
//  ImageProcessor.m
//  DozeDetector
//
//  Created by Craig Thrall on 11/21/15.
//  Copyright © 2015 Craig Thrall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageProcessor.h"

@interface ImageProcessor ()

@end

@implementation ImageProcessor

-(id)initWithView:(UIImageView*) imageView {
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    
    self.speechAlert = [[SpeechAlert alloc] init];
    
    NSString* facePath = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_alt2" ofType:@"xml"];
    NSString* eyePath = [[NSBundle mainBundle] pathForResource:@"haarcascade_eye" ofType:@"xml"];
    
    eyeDetector = [[EyeDetector alloc] initWithCascade:@"haarcascade_eye"
                                             withColor:CV_RGB(0, 255, 0)];

    eyeDetector2 = [[EyeDetector alloc] initWithCascade:@"haarcascade_mcs_eyepair_small"
                                             withColor:CV_RGB(0, 0, 255)];
    
    faceCascade.load([facePath UTF8String]);
    eyeCascade.load([eyePath UTF8String]);
    
    eyeAccum = 0;
    sampleCount = 0;
    calibrated = false;

    startTime = CACurrentMediaTime();
    
    return self;
}

-(void)detect {
    [self.videoCamera start];
}

-(void)calibrate {
    NSLog(@"Calibrating");
    calibrated = false;
}

#ifdef __cplusplus
- (void) processImage:(Mat&) image {
    float haarScale = 1.3;
    cv::Size minSize = cvSize(30, 30);
    int minNeighbors = 2;
    int haarFlags = 0 | CV_HAAR_DO_CANNY_PRUNING;
    // int haarFlags = 0 | CV_HAAR_SCALE_IMAGE
    
    if (!calibrated) {
        if (faces.size() < 1) {
            faceCascade.detectMultiScale(image, faces, haarScale, minNeighbors, haarFlags, minSize);
            NSLog(@"Found %lu faces", faces.size());
        }
        
        calibrated = true;
    }
    
    if (faces.size() > 0) {
        //eyeCascade.detectMultiScale(image(faces[0]), eyes, haarScale, 2, haarFlags, cvSize(20, 20));
        //NSLog(@"Found %d eyes", eyes.size());
        
//        eyeAccum += eyes.size();
//        sampleCount += 2;
//        
//        cv::Rect rect;
//        if (eyes.size()) {
//            rect = eyes[0] + cv::Point(faces[0].x,
//                                       faces[0].y);
//            cv::rectangle(image, rect, CV_RGB(0, 255, 0));
//        }
        eyeAccum += [eyeDetector processImage:image forFaces:faces];
        //[eyeDetector2 processImage:image forFaces:faces];
        sampleCount += 2;
    }
    
    CFTimeInterval sampleTime = CACurrentMediaTime();
    //NSLog(@"%f %f %f", sampleTime, startTime, samplePeriod);
    if (sampleTime - startTime > samplePeriod) {
        if (sampleCount > minSampleCount) {
            percentOpen = (eyeAccum / sampleCount) * 100;
            if (percentOpen < 80) {
                NSLog(@"Under threshold %f", percentOpen);
                [self.speechAlert speakWarning];
            } else {
                NSLog(@"Over threshold: %f", percentOpen);
            }
        } else {
            NSLog(@"Not enough samples");
        }
        
        eyeAccum = 0;
        sampleCount = 0;
        startTime = sampleTime;
    }
}
#endif

@end

@interface EyeDetector ()

@end

@implementation EyeDetector
-(id) initWithCascade:(NSString*) cascadeName withColor:(const Scalar&)initColor {
    NSString* eyePath = [[NSBundle mainBundle] pathForResource:cascadeName ofType:@"xml"];
    eyeCascade.load([eyePath UTF8String]);
    highlightColor = initColor;
    
    return self;
}

-(int) processImage:(Mat&) image forFaces:(std::vector<cv::Rect>&)faces {
    std::vector<cv::Rect> eyes;
    if (faces.size() > 0) {
        float haarScale = 1.3;
        int haarFlags = 0 | CV_HAAR_DO_CANNY_PRUNING;

        eyeCascade.detectMultiScale(image(faces[0]), eyes, haarScale, 2, haarFlags, cvSize(20, 20));
        cv::Rect rect;
        if (eyes.size()) {
            rect = eyes[0] + cv::Point(faces[0].x,
                                       faces[0].y);
            cv::rectangle(image, rect, highlightColor);
        }
    }
    
    return eyes.size();
}
@end