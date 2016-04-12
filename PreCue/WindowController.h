//
//  WindowController.h
//  PreCue
//
//  Created by Brian J. Cardiff on 4/11/16.
//  Copyright © 2016 bcardiff. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EZAudio/EZAudioPlayer.h"
#import "MainWindow.h"

@interface WindowController : NSWindowController <EZAudioPlayerDelegate, MainWindowDelegate>
{
    EZAudioPlayer *player;
}

- (void)loadFile:(NSURL *)fileURL;
@end
