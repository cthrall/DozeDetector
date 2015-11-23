//
//  SpeechAlert.h
//  EyeFinder
//
//  Created by Craig Thrall on 11/22/15.
//  Copyright © 2015 Craig Thrall. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface SpeechAlert : AVSpeechSynthesizer<AVSpeechSynthesizerDelegate>
{
}

-(id) init;
-(void) speakWarning;
- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance;

@property (nonatomic, retain) AVSpeechUtterance* speechUtterance;
@property (nonatomic, retain) AVSpeechSynthesizer *speechSynthesizer;

@end