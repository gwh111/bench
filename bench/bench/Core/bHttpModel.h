//
//  bHttpModel.h
//  bench
//
//  Created by gwh on 2022/6/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface bHttpModel : NSObject

@property (nonatomic, retain) NSDictionary *responseDic;
@property (nonatomic, retain) NSString *responseDate;
@property (nonatomic, retain) NSString *resultStr;

@end

NS_ASSUME_NONNULL_END
