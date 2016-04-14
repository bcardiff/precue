//
//  MainWindow.h
//  PreCue
//
//  Created by Brian J. Cardiff on 4/11/16.
//  Copyright © 2016 bcardiff. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol MainViewDelegate < NSObject >

- (void)loadFile:(NSURL *)fileURL;
- (void)seekFile:(double)position;

@end

@interface MainView : NSView <NSDraggingDestination>

@property (nonatomic, assign) IBOutlet id<MainViewDelegate> mainDelegate;
@property (nonatomic, assign) IBOutlet NSProgressIndicator* trackProgress;

@end
