//
//  MainWindow.h
//  PreCue
//
//  Created by Brian J. Cardiff on 4/11/16.
//  Copyright © 2016 bcardiff. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol MainWindowDelegate < NSObject >

- (void)loadFile:(NSURL *)fileURL;

@end

@interface MainWindow : NSWindow <NSDraggingDestination>

@property (nonatomic, assign) IBOutlet id<MainWindowDelegate> mainDelegate;

@end
