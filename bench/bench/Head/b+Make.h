//
//  b+Make.h
//  bench
//
//  Created by gwh on 2023/1/1.
//

#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (Make)

+ (NSString *)getRandomStringWithNum:(NSInteger)num;

+ (NSString *)subStringWithEmoji:(NSString *)emojiString limitLength:(NSInteger)limitLength;

@end

NS_ASSUME_NONNULL_END
