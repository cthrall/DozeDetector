//
//  ViewController.h
//  EyeFinder
//
//  Created by Craig Thrall on 11/1/15.
//  Copyright © 2015 Craig Thrall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/objdetect/objdetect.hpp>
#import <opencv2/videoio/cap_ios.h>

using namespace cv;

@interface ViewController : UIViewController<CvVideoCameraDelegate>
{
    __weak IBOutlet UIImageView *imageView;
    CvVideoCamera* videoCamera;
    CascadeClassifier faceCascade;
    CascadeClassifier eyeCascade;
    std::vector<cv::Rect> faces;
    std::vector<cv::Rect> eyes;
}

@property (nonatomic, retain) CvVideoCamera* videoCamera;

@end
