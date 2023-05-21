//
//  bHTML.m
//  bench
//
//  Created by gwh on 2022/12/1.
//

#import "b+HTML.h"

@implementation b (HTML)

+ (void)html {
    
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
     
   NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
   NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
   NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
   NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
   NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                          mutabilityOption:NSPropertyListImmutable
                                                                    format:NULL
                                                          errorDescription:NULL];
   return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

+ (NSString *)html:(NSString *)html findLabelStart:(NSString *)start end:(NSString *)end except:(nullable NSArray *)excepts removeStartEnd:(BOOL)remove {
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    NSString *pStr = @"";
    while([scanner isAtEnd] == NO) {
        [scanner scanUpToString:start intoString:nil];
        [scanner scanUpToString:end intoString:&text];
        
        if (text.length > 0) {
            int can = 1;
            for (int i = 0; i < excepts.count; i++) {
                NSString *key = excepts[i];
                if ([text containsString:key]) {
                    can = 0;
                }
            }
            if ([pStr containsString:text]) {
                can = NO;
            }
            if (can) {
                pStr = [NSString stringWithFormat:@"%@%@%@",pStr,text,end];
                break;;
            }
        }
    }
    if (remove) {
        pStr = [pStr stringByReplacingOccurrencesOfString:start withString:@""];
        pStr = [pStr stringByReplacingOccurrencesOfString:end withString:@""];
    }
    
    return pStr;
}

+ (NSArray *)html:(NSString *)html findLabelsStart:(NSString *)start end:(NSString *)end except:(nullable NSArray *)excepts removeStartEnd:(BOOL)remove {
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    NSMutableArray *list = NSMutableArray.new;
    NSString *pStr = @"";
    while([scanner isAtEnd] == NO) {
        [scanner scanUpToString:start intoString:nil];
        [scanner scanUpToString:end intoString:&text];
        
        if (text.length > 0) {
            int can = 1;
            for (int i = 0; i < excepts.count; i++) {
                NSString *key = excepts[i];
                if ([text containsString:key]) {
                    can = 0;
                }
            }
            if ([pStr containsString:text]) {
                can = NO;
            }
            if (can) {
                pStr = [NSString stringWithFormat:@"%@%@%@",pStr,text,end];
                
                if (remove) {
                    pStr = [pStr stringByReplacingOccurrencesOfString:start withString:@""];
                    pStr = [pStr stringByReplacingOccurrencesOfString:end withString:@""];
                }
                
                [list addObject:pStr];
                pStr = @"";
            }
        }
    }
    if (list.count > 1) {
        [list removeLastObject];
    }
    return list;
}

+ (NSString *)replaceHtmlLabel:(NSString *)htmlStr labelName:(NSString *)labelName toLabelName:(NSString *)toLabelName trimSpace:(BOOL)trimSpace {
    NSScanner *theScanner = [NSScanner scannerWithString:htmlStr];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:[NSString stringWithFormat:@"<%@",labelName] intoString:NULL];
        [theScanner scanUpToString:@">" intoString:&text];
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]withString:toLabelName];
    }
    return trimSpace ? [htmlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : htmlStr;
}

@end
