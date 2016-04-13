//
//  ViewController.h
//  PreCue
//
//  Created by Brian J. Cardiff on 2/27/16.
//  Copyright © 2016 bcardiff. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EZAudio/EZAudioPlayer.h"
#import "EZAudio/EZAudioDevice.h"
#import "MainView.h"

@interface MainViewController : NSViewController <EZAudioPlayerDelegate, MainViewDelegate>
{
    EZAudioPlayer *player;
    NSArray *inputDevices;
}

- (void)loadFile:(NSURL *)fileURL;
- (IBAction)play:(id)sender;

@property (readwrite, assign) int volumenValue;
-(IBAction)volumenMoved:(id)sender;

@property (readwrite, assign) double trackFrames;
@property (readwrite, assign) double trackCurrentFrame;

@property (readwrite, retain) NSArray *outputDevices;
@property (readwrite, retain) EZAudioDevice *selectedOutputDevice;
- (IBAction)deviceChange:(id)sender;

- (void)registerHotKeys;

@end

