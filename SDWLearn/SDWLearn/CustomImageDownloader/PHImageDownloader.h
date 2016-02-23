//
//  PHImageDownloader.h
//  SDWLearn
//
//  Created by Apple on 16/2/23.
//  Copyright © 2016年 gph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PHImageCacheQueue.h"

@class PHImageDownloader;

@protocol PHImageDownloadDelegate <NSObject>

-(void)imageDownloader:(PHImageDownloader*)downloader didFinishWithImage:(UIImage*)image;
-(void)imageDownloader:(PHImageDownloader*)downloader didFailWithError:(NSError*)error;

@end

@interface PHImageDownloader : NSObject

+(id)sharedDownloader;

-(void)startDownloadImageWithUrl:(NSString*)url andDelegate:(id<PHImageDownloadDelegate>)aDelegate;

@end
