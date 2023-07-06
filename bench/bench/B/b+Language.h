//
//  b+Language.h
//  bench
//
//  Created by apple on 2023/7/6.
//

#import "b.h"

NS_ASSUME_NONNULL_BEGIN

#define TEXT(text) [b getText:text key:b.bundleID]
#define TEXT_KEY(text,key) [b getText:a key:key]

@interface b (Language)

+ (NSString *)getText:(NSString *)text key:(NSString *)key;

// 默认多语言文件路径
+ (void)setDefaultPath:(NSString *)path;
// 负载均衡
+ (void)setPath:(NSString *)path key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
