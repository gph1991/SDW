//
//  YFF_BaseModel.h
//  XiaomaTOEFL
//
//  Created by Yanfang.符 on 14-9-1.
//  Copyright (c) 2014年 www.xiaoma.com 小马过河互联网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored "-Warc-performSelector-leaks"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface YFF_BaseModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSArray *dataArr;

- (id)initWithDataDic:(NSDictionary *)data;
- (NSDictionary *)attributeMapDictionary;
- (void)setAttributes:(NSDictionary *)dataDic;//命名不一致。通过复写此方法手动设置即可
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;                 //数据归档
- (NSString *)cleanString:(NSString *)str;  //清除\n和\r的字符串

@end
