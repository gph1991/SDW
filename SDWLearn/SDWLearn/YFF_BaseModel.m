//
//  YFF_BaseModel.m
//  XiaomaTOEFL
//
//  Created by Yanfang.符 on 14-9-1.
//  Copyright (c) 2014年 www.xiaoma.com 小马过河互联网科技有限公司. All rights reserved.
//

#import "YFF_BaseModel.h"
#import <objc/runtime.h>

@implementation YFF_BaseModel

-(id)initWithDataDic:(NSDictionary*)data
{
	if (self = [super init])
    {
		[self setAttributes:data];
	}
	return self;
}

-(NSDictionary*)attributeMapDictionary
{
	return nil;
}

-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName
{
	NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
	NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
	return NSSelectorFromString(setterSelStr);
}

- (NSString *)customDescription
{
	return nil;
}

- (NSString *)description
{
	NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	
	while ((attributeName = [keyEnum nextObject]))
    {
		SEL getSel = NSSelectorFromString(attributeName);
		if ([self respondsToSelector:getSel])
        {
			NSMethodSignature *signature = nil;
			signature = [self methodSignatureForSelector:getSel];
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:getSel];
			NSObject *valueObj = nil;
			[invocation invoke];
			[invocation getReturnValue:&valueObj];
			if (valueObj)
            {
				[attrsDesc appendFormat:@" [%@=%@] ",attributeName, valueObj];
			}
            else
            {
				[attrsDesc appendFormat:@" [%@=nil] ",attributeName];
			}
			
		}
	}
	
	NSString *customDesc = [self customDescription];
	NSString *desc;
	
	if (customDesc && [customDesc length] > 0 )
    {
		desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
	}
    else
    {
		desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
	}
    
	return desc;
}

-(void)setAttributes:(NSDictionary*)dic
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *key = [[NSString alloc]initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *selectorStr = [NSString stringWithFormat:@"set%@%@:",[[key substringToIndex:1] uppercaseString], [key substringFromIndex:1]];
        
        id obj = nil;
        if ([dic objectForKey:key] != nil)
        {
            if (![[dic objectForKey:key] isEqual:[NSNull null]])
            {
                obj = [dic objectForKey:key];
            }
        }
        
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"  //用来消除leaks警告
        [self performSelector:NSSelectorFromString(selectorStr) withObject:obj];
    }
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
	if( self = [super init] )
    {
		NSDictionary *attrMapDic = [self attributeMapDictionary];
		if (attrMapDic == nil)
        {
			return self;
		}
		NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
		id attributeName;
		while ((attributeName = [keyEnum nextObject]))
        {
			SEL sel = [self getSetterSelWithAttibuteName:attributeName];
			if ([self respondsToSelector:sel])
            {
				id obj = [decoder decodeObjectForKey:attributeName];
				[self performSelectorOnMainThread:sel
                                       withObject:obj
                                    waitUntilDone:[NSThread isMainThread]];
			}
		}
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
		SEL getSel = NSSelectorFromString(attributeName);
		if ([self respondsToSelector:getSel]) {
			NSMethodSignature *signature = nil;
			signature = [self methodSignatureForSelector:getSel];
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:getSel];
			NSObject *valueObj = nil;
			[invocation invoke];
			[invocation getReturnValue:&valueObj];
			
			if (valueObj) {
				[encoder encodeObject:valueObj forKey:attributeName];
			}
		}
	}
}

- (NSData*)getArchivedData{
	return [NSKeyedArchiver archivedDataWithRootObject:self];
}

- (NSString *)cleanString:(NSString *)str {
    if (str == nil) {
        return @"";
    }
    NSMutableString *cleanString = [NSMutableString stringWithString:str];
    [cleanString replaceOccurrencesOfString:@"\n" withString:@""
                                    options:NSCaseInsensitiveSearch
                                      range:NSMakeRange(0, [cleanString length])];
    [cleanString replaceOccurrencesOfString:@"\r" withString:@""
                                    options:NSCaseInsensitiveSearch
                                      range:NSMakeRange(0, [cleanString length])];
    return cleanString;
}

#ifdef _FOR_DEBUG_
-(BOOL) respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector];
}
#endif


@end
