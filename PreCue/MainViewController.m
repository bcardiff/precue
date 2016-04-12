//
//  ViewController.m
//  PreCue
//
//  Created by Brian J. Cardiff on 2/27/16.
//  Copyright © 2016 bcardiff. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    player = [EZAudioPlayer audioPlayerWithDelegate:self];
    self.volumenValue = 100;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)loadFile:(NSURL *)fileURL {
    EZAudioFile *audioFile = [EZAudioFile audioFileWithURL:fileURL];
    [player playAudioFile:audioFile];
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

@end
