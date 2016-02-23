//
//  PHImageDownloader.m
//  SDWLearn
//
//  Created by Apple on 16/2/23.
//  Copyright © 2016年 gph. All rights reserved.
//

#import "PHImageDownloader.h"

static PHImageDownloader *sharedModel = nil;

@interface PHImageDownloader()
{
    NSOperationQueue *operationQueue;
    PHImageCacheQueue *cacheModel;
}

@end

@implementation PHImageDownloader

+(id)sharedDownloader
{
    @synchronized(self) {
        if(!sharedModel)
        {
            sharedModel = [[PHImageDownloader alloc]init];
        }
        
        return sharedModel;
    }

}

-(instancetype)init
{
    
    self = [super init];
    if (self)
    {
        operationQueue = [[NSOperationQueue alloc]init];
        cacheModel = [PHImageCacheQueue sharedInstance];
    }
    
    return self;
}

-(void)startDownloadImageWithUrl:(NSString *)url andDelegate:(id<PHImageDownloadDelegate>)aDelegate
{
    NSDictionary *dic = @{DELEGATE:aDelegate,URL_KEY:url};
    [operationQueue addOperation:[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(startDownloadImage:) object:dic]];
}

-(void)startDownloadImage:(NSDictionary*)info
{
    UIImage *image = nil;
    id delegate = [info objectForKey:DELEGATE];

    image = [cacheModel tryToCacheImageWithKey:[info objectForKey:URL_KEY]];
    if (image)
    {
        if ([delegate respondsToSelector:@selector(imageDownloader:didFinishWithImage:)])
        {
            [delegate imageDownloader:self didFinishWithImage:image];
        }
    }
    else
    {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[info objectForKey:URL_KEY]]];
        UIImage *image = [UIImage imageWithData:data];
        [cacheModel cacheImage:image withKey:[info objectForKey:URL_KEY]];
        
        if ([delegate respondsToSelector:@selector(imageDownloader:didFinishWithImage:)])
        {
            [delegate imageDownloader:self didFinishWithImage:image];
        }
    }
}

@end
