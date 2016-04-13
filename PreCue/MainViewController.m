//
//  ViewController.m
//  PreCue
//
//  Created by Brian J. Cardiff on 2/27/16.
//  Copyright © 2016 bcardiff. All rights reserved.
//

#import "MainViewController.h"
#import "EZAudio/EZAudioUtilities.h"
#import <Carbon/Carbon.h>


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    player = [EZAudioPlayer audioPlayerWithDelegate:self];

//    [EZAudioUtilities setShouldExitOnCheckResultFail: false];
    self.outputDevices = [EZAudioDevice outputDevices];
//    [EZAudioUtilities setShouldExitOnCheckResultFail: true];

    self.selectedOutputDevice = [EZAudioDevice currentOutputDevice];
    
    self.volumenValue = 40;
    [self volumenMoved: self];
    [self registerHotKeys];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)loadFile:(NSURL *)fileURL {
    EZAudioFile *audioFile = [EZAudioFile audioFileWithURL:fileURL];
    
    self.formattedDuration = audioFile.formattedDuration;
    self.trackArtist = [audioFile.metadata objectForKey:@"artist"];
    self.trackTitle = [audioFile.metadata objectForKey:@"title"];
    self.formattedCurrentTime = audioFile.formattedCurrentTime;
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

    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.trackCurrentFrame = framePosition;
        weakSelf.formattedCurrentTime = audioFile.formattedCurrentTime;
    });
}

- (void)registerHotKeys {
    EventHotKeyRef gMyHotKeyRef;
    EventHotKeyID gMyHotKeyID;
    EventTypeSpec eventType;
    eventType.eventClass=kEventClassKeyboard;
    eventType.eventKind=kEventHotKeyPressed;
    InstallApplicationEventHandler(&MyHotKeyHandler, 1, &eventType, (__bridge void*) self, NULL);
    gMyHotKeyID.signature='rml1';
    gMyHotKeyID.id=1;
    RegisterEventHotKey(kVK_ANSI_P, cmdKey, gMyHotKeyID,GetApplicationEventTarget(), 0, &gMyHotKeyRef);
}

NSString* getSelectedItunesTrack() {
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/osascript";
    NSString* script = @"tell application \"iTunes\" to location of selection";
    task.arguments  = @[@"-e", script];
    
    NSPipe *stdout = [NSPipe pipe];
    [task setStandardOutput:stdout];
    
    [task launch];
    [task waitUntilExit];
    
    NSFileHandle * read = [stdout fileHandleForReading];
    NSData * dataRead = [read readDataToEndOfFile];
    NSString * stringRead = [[NSString alloc] initWithData:dataRead encoding:NSUTF8StringEncoding];
    
    return stringRead;
}

OSStatus MyHotKeyHandler(EventHandlerCallRef nextHandler,EventRef theEvent, void *data) {
    NSString* itunesTrack = getSelectedItunesTrack();
    NSString* buildPath = [itunesTrack stringByReplacingOccurrencesOfString:@":" withString:@"/"];
    buildPath = [buildPath substringFromIndex:[buildPath rangeOfString:@"/"].location];
    buildPath = [buildPath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSURL* fileUrl = [NSURL fileURLWithPath: buildPath
                                isDirectory: NO];
    
    MainViewController *_self = (__bridge id) data;
    [_self loadFile:fileUrl];

    return noErr;
}

@end
