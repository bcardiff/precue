//
//  ViewController.m
//  PreCue
//
//  Created by Brian J. Cardiff on 2/27/16.
//  Copyright © 2016 bcardiff. All rights reserved.
//

#import "MainViewController.h"
#import "EZAudio/EZAudioUtilities.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    player = [EZAudioPlayer audioPlayerWithDelegate:self];

//    [EZAudioUtilities setShouldExitOnCheckResultFail: false];
    self.outputDevices = [EZAudioDevice outputDevices];
//    [EZAudioUtilities setShouldExitOnCheckResultFail: true];

    self.selectedOutputDevice = [EZAudioDevice currentOutputDevice];
    
    self.volumenValue = 100;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)loadFile:(NSURL *)fileURL {
    EZAudioFile *audioFile = [EZAudioFile audioFileWithURL:fileURL];
    
    self.trackFrames = [audioFile totalFrames];
    self.trackCurrentFrame = 0;

    [player setDevice: self.selectedOutputDevice];

    [player playAudioFile:audioFile];
}

- (IBAction)deviceChange:(id)sender {
    [player setDevice: self.selectedOutputDevice];
}

- (IBAction)play:(id)sender {
    if (player.isPlaying) {
        [player pause];
    } else {
        [player play];
    }
}

-(IBAction)volumenMoved:(id)sender {
    [player setVolume:self.volumenValue / 100.0];
}

- (void)seekFile:(double)position {
    [player seekToFrame: self.trackFrames * position];
}

- (void)audioPlayer:(EZAudioPlayer *)audioPlayer
    updatedPosition:(SInt64)framePosition
        inAudioFile:(EZAudioFile *)audioFile
{
    __weak typeof (self) weakSelf = self;
    // Update any UI controls including sliders and labels
    // display current time/duration
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.trackCurrentFrame = framePosition;
//        if (!weakSelf.positionSlider.highlighted)
//        {
//            weakSelf.positionSlider.floatValue = (float)framePosition;
//            weakSelf.positionLabel.integerValue = framePosition;
//        }
    });
}

@end
