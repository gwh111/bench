//
//  b+Make.m
//  bench
//
//  Created by gwh on 2023/1/1.
//

#import "b+Make.h"

@implementation b (Make)

+ (NSArray *)cutLongSentenceToList:(NSString *)content {
    NSArray *talks = [content componentsSeparatedByString:@"。"];
    NSMutableArray *mutTalk = NSMutableArray.new;
    for (int i = 0; i < talks.count; i++) {
        NSString *c = talks[i];
        c = [c stringByAppendingString:@"。"];
        if (c.length > 30) {
            if ([c containsString:@"！"]) {
                NSArray *sp2 = [c componentsSeparatedByString:@"！"];
                for (int i = 0; i < sp2.count; i++) {
                    NSString *c = sp2[i];
                    c = [c stringByAppendingString:@"！"];
                    if (c.length > 30) {
                        if ([c containsString:@"？"]) {
                            NSArray *sp2 = [c componentsSeparatedByString:@"？"];
                            for (int i = 0; i < sp2.count; i++) {
                                NSString *c = sp2[i];
                                c = [c stringByAppendingString:@"？"];
                                if (c.length <= 2) {
                                    continue;;
                                }
                                [mutTalk addObject:c];
                            }
                            continue;
                        }
                    }
                    if (c.length <= 2) {
                        continue;;
                    }
                    [mutTalk addObject:c];
                }
                continue;
            }
        }
        if (c.length <= 2) {
            continue;;
        }
        [mutTalk addObject:c];
    }
    return mutTalk;
}

//截取字符前多少位，处理emoji表情问题
////🐒🐒🐒🐒 + 截取3 = 🐒🐒🐒
+ (NSString *)subStringWithEmoji:(NSString *)emojiString limitLength:(NSInteger)limitLength {
    if(emojiString.length < limitLength) return emojiString;
    
    @autoreleasepool {
        NSString * subStr = emojiString;
        NSRange  range;
        NSInteger index = 0;
        for(int i=0; i< emojiString.length; i += range.length){
            range = [emojiString rangeOfComposedCharacterSequenceAtIndex:i];
            NSString * charrrr = [emojiString substringToIndex:range.location + range.length];
            index ++;
            if(index == limitLength){
                subStr = charrrr;
                break;
            }
        }
        return subStr;
    }
}

+ (NSString *)getRandomStringWithNum:(NSInteger)num {
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

+ (int)getRandom:(int)number {
    return arc4random()%number;
}

@end
