//
//  UIImageView+PHDownloader.m
//  SDWLearn
//
//  Created by Apple on 16/2/23.
//  Copyright © 2016年 gph. All rights reserved.
//

#import "UIImageView+PHDownloader.h"

@implementation UIImageView (PHDownloader)

-(void)downloadImageWithUrlKey:(NSString *)url
{
    [self downloadImageWithUrlKey:url placeHolderImage:nil];
}

-(void)downloadImageWithUrlKey:(NSString *)url placeHolderImage:(UIImage *)image
{
    if (image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    }
    
    PHImageDownloader *downloader = [PHImageDownloader sharedDownloader];
    [downloader startDownloadImageWithUrl:url andDelegate:self];
}

-(void)imageDownloader:(PHImageDownloader *)downloader didFinishWithImage:(UIImage *)image
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = image;
    });
}

-(void)imageDownloader:(PHImageDownloader *)downloader didFailWithError:(NSError *)error
{
    
}

@end

