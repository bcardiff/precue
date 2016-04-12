//
//  WindowController.m
//  PreCue
//
//  Created by Brian J. Cardiff on 4/11/16.
//  Copyright © 2016 bcardiff. All rights reserved.
//

#import "WindowController.h"

@interface WindowController ()

@end

@implementation WindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    player = [EZAudioPlayer audioPlayerWithDelegate:self];
}

- (void)loadFile:(NSURL *)fileURL {
    EZAudioFile *audioFile = [EZAudioFile audioFileWithURL:fileURL];
    [player playAudioFile:audioFile];
}
@end
