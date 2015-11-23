//
//  SpeechAlert.m
//  EyeFinder
//
//  Created by Craig Thrall on 11/22/15.
//  Copyright © 2015 Craig Thrall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpeechAlert.h"

@interface SpeechAlert ()

@end

@implementation SpeechAlert

-(id) init {
    self = [super init];
    
    self.speechUtterance = [[AVSpeechUtterance alloc] initWithString:@"Wake up!"];
    
    // There's a bug in iOS 9 that results in the OS not finding the specified voice
    // even if it's loaded on the device. A temporary workaround is to iterate over
    // all voices, and find the first one with the language you're looking for.
    // The downside is this will not use the voice the user has selected in "Settings."
    NSArray* voices = [AVSpeechSynthesisVoice speechVoices];
    for (AVSpeechSynthesisVoice* voice in voices) {
        if (voice &&
            [voice.language isEqual: @"en-US"]) {
            NSLog(@"Name: %@ Language: %@", voice.name, voice.language);
            self.speechUtterance.voice = voice;
            break;
        }
    }
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.speechSynthesizer.delegate = self;
    
    return self;
}

-(void) speakWarning {
    if (!self.speechSynthesizer.isSpeaking) {
        NSLog(@"Speaking");
        [self.speechSynthesizer speakUtterance:self.speechUtterance];
    }
}

- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"Done talking");
}

@end
