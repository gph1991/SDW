//
//  PHImageCacheQueue.m
//  SDWLearn
//
//  Created by Apple on 16/2/23.
//  Copyright © 2016年 gph. All rights reserved.
//

#import "PHImageCacheQueue.h"

@interface PHImageCacheQueue()
{
    NSMutableDictionary *cache;
    NSString *filePath;
}
@end

static PHImageCacheQueue *model = nil;

@implementation PHImageCacheQueue

+(id)sharedInstance
{
    if (!model) {
        model = [[PHImageCacheQueue alloc]init];
    }
    
    return model;
}

-(instancetype)init
{
    self = [super init];
    cache = [[NSMutableDictionary alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    filePath =  [paths[0] stringByAppendingPathComponent:@"ImageChache"];
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:filePath])
    {
        NSError *error;
        [[NSFileManager defaultManager]createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    return self;
}


-(UIImage *)tryToCacheImageWithKey:(NSString *)key
{
    UIImage *image = nil;
    image = [self cacheImageInMemoryWithKey:key];
    if (image)
    {
        return image;
    }
    else
    {
        image = [self cacheImageInDiskWithKey:key];
        if (image)
        {
            return image;
        }
    }
    
    return nil;
}

-(UIImage *)cacheImageInMemoryWithKey:(NSString *)key
{
    if ([cache objectForKey:[key MD5]])
    {
        return [cache objectForKey:[key MD5]];
    }
    
    return nil;
}

-(UIImage *)cacheImageInDiskWithKey:(NSString *)key
{
    NSString *tmpPath = [filePath stringByAppendingString:[key MD5]];
    UIImage *image = [UIImage imageWithContentsOfFile:tmpPath];
    
    if (image)
    {
        [self cacheImageToMemory:image withKey:key];
        return image;
    }
    
    return nil;
}

-(void)cacheImage:(UIImage *)image withKey:(NSString *)key
{
    [self cacheImageToMemory:image withKey:key];
    [self cacheImageToDisk:image withKey:key];
}

-(void)cacheImageToMemory:(UIImage *)image withKey:(NSString *)key
{
    [cache setObject:image forKey:[key MD5]];
}

-(void)cacheImageToDisk:(UIImage *)image withKey:(NSString *)key
{
    NSString *tmpPath = [filePath stringByAppendingPathComponent:[key MD5]];
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    
    if (data.length > 0)
    {
        [[NSFileManager defaultManager]createFileAtPath:tmpPath contents:data attributes:nil];
    }
}

-(void)clearCache
{
    [self clearMemoryCache];
    [self clearDiskCache];
}

-(void)clearMemoryCache
{
    [cache removeAllObjects];
}

-(void)clearDiskCache
{
    NSError *error;
    [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
    
    [[NSFileManager defaultManager]createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
}

-(void)dealloc
{
    [cache removeAllObjects];
    cache = nil;
    filePath = nil;
}

@end
