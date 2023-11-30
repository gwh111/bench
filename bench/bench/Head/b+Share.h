//
//  b+Share.h
//  bench
//
//  Created by apple on 2023/7/6.
//

#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (Share)

// 可重入
+ (void)setSharedKey:(NSString *)key object:(id)object;
// 不可重入
+ (void)addSharedKey:(NSString *)key object:(id)object;

+ (id)getSharedKey:(NSString *)key;

+ (void)copyToPastBoard:(NSString *)text;
+ (NSString *)pasteboardText;

@end

NS_ASSUME_NONNULL_END
