//
//  bEvent.m
//  bench
//
//  Created by gwh on 2025/3/17.
//

#import "bEvent.h"

@interface Subscription : NSObject
@property (nonatomic, weak) id owner;
@property (nonatomic, copy) void (^block)(id _Nullable data);
@end

@implementation Subscription
@end

@interface bEvent ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<Subscription *> *> *subscriptions;
@property (nonatomic, strong) dispatch_queue_t syncQueue;
@end

@implementation bEvent

+ (instancetype)shared {
    static bEvent *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[bEvent alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _subscriptions = [NSMutableDictionary dictionary];
        _syncQueue = dispatch_queue_create("com.example.EventDispatcher", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)subscribeEvent:(NSString *)eventName
                owner:(id)owner
               block:(void (^)(id _Nullable data))block
{
    if (!eventName || !owner || !block) return;
    
    Subscription *sub = [[Subscription alloc] init];
    sub.owner = owner;
    sub.block = block;
    
    // 线程安全操作
    dispatch_async(self.syncQueue, ^{
        NSMutableArray *subs = self.subscriptions[eventName];
        if (!subs) {
            subs = [NSMutableArray array];
            self.subscriptions[eventName] = subs;
        }
        [subs addObject:sub];
    });
}

- (void)dispatchEvent:(NSString *)eventName
                data:(id _Nullable)data
{
    if (!eventName) return;
    
    dispatch_async(self.syncQueue, ^{
        NSMutableArray *subs = [self.subscriptions[eventName] mutableCopy];
        NSMutableArray *toRemove = [NSMutableArray array];
        
        // 清理无效订阅
        for (Subscription *sub in subs) {
            if (!sub.owner) {
                [toRemove addObject:sub];
            }
        }
        [subs removeObjectsInArray:toRemove];
        self.subscriptions[eventName] = subs;
        
        // 执行所有有效block
        for (Subscription *sub in subs) {
            dispatch_async(dispatch_get_main_queue(), ^{
                sub.block(data);
            });
        }
    });
}

@end
