//
//  PHImageCacheQueue.h
//  SDWLearn
//
//  Created by Apple on 16/2/23.
//  Copyright © 2016年 gph. All rights reserved.
//


#define URL_KEY @"urlkey"
#define DELEGATE @"delegate"

#import "NSString+MD5.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PHImageCacheQueue : NSObject

+(id)sharedInstance;

-(UIImage*)tryToCacheImageWithKey:(NSString*)key;

-(void)clearCache;
-(void)cacheImage:(UIImage*)image withKey:(NSString*)key;

@end
