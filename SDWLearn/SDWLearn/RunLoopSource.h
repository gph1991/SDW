//
//  RunLoopSource.h
//  SDWLearn
//
//  Created by Apple on 15/11/20.
//  Copyright © 2015年 gph. All rights reserved.
//
#import "AppDelegate.h"
#import <Foundation/Foundation.h>

@interface RunLoopSource : NSObject
{
    CFRunLoopSourceRef runLoopSource;
    NSMutableArray *commands;
}

-(instancetype)init;
-(void)addToCurrentRunLoop;
-(void)invalidate;

//handler method
-(void)sourceFired;

//client interface for registering commands to process
-(void)addCommand:(NSInteger)command withData:(id)data;
-(void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runLoop;

@end

void RunLoopSourceScheduleRoutine (void *info,CFRunLoopRef rl,CFStringRef mode);
void RunLoopSourcePerformRoutine (void *info);
void RunLoopSourceCancelRoutine (void *info,CFRunLoopRef rl,CFStringRef mode);

//void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
//{
//    RunLoopSource * obj = (__bridge RunLoopSource*)info;
//    AppDelegate *del = [UIApplication sharedApplication].delegate;
//    RunLoopContext *theContext = [[RunLoopContext alloc] initWithSource:obj andLoop:rl];
//    
//    [del performSelectorOnMainThread:@selector(registerSource:)
//                          withObject:theContext waitUntilDone:NO];
//};

@interface RunLoopContent : NSObject
{
    CFRunLoopRef runLoop;
    RunLoopSource *source;
}

@property(readonly)CFRunLoopRef runLoop;
@property(readonly)RunLoopSource *source;

-(instancetype)initWithSource:(RunLoopSource*)src andLoop:(CFRunLoopRef)loop;

@end

