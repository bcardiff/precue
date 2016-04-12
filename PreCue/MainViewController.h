//
//  ViewController.h
//  PreCue
//
//  Created by Brian J. Cardiff on 2/27/16.
//  Copyright © 2016 bcardiff. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EZAudio/EZAudioPlayer.h"
#import "MainView.h"

@interface MainViewController : NSViewController <EZAudioPlayerDelegate, MainViewDelegate>
{
    EZAudioPlayer *player;
}

- (void)loadFile:(NSURL *)fileURL;
@end

