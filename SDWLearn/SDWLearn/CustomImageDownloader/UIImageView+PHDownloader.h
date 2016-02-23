//
//  UIImageView+PHDownloader.h
//  SDWLearn
//
//  Created by Apple on 16/2/23.
//  Copyright © 2016年 gph. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "PHImageDownloader.h"

@interface UIImageView (PHDownloader)<PHImageDownloadDelegate>

-(void)downloadImageWithUrlKey:(NSString*)url;
-(void)downloadImageWithUrlKey:(NSString*)url placeHolderImage:(UIImage*)image;


@end
