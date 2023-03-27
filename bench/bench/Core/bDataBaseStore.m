//
//  CC_DataBaseStore.m
//  DataStorageDemo
//
//  Created by relax on 2019/9/11.
//  Copyright © 2019 qq. All rights reserved.
//

#import "bDataBaseStore.h"
#import "bDatabaseTool.h"
#import "bDatabase.h"
#import "b.h"

static const void * const kDispatchQueueSpecificKey = &kDispatchQueueSpecificKey;

@interface bDataBaseStore ()

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) bDatabase *db;
@property (nonatomic, readwrite, nonnull) NSString *databasePath;

@end

static bDataBaseStore *userManager = nil;
static dispatch_once_t onceToken;

@implementation bDataBaseStore

+ (instancetype)shared {
    dispatch_once(&onceToken, ^{
        userManager = [[bDataBaseStore alloc]init];
        [userManager start];
    });
    return userManager;
}

- (void)setupDBWithName:(NSString *)name {
    _queue = dispatch_queue_create([[NSString stringWithFormat:@"bench.%@", self] UTF8String], NULL);
    dispatch_queue_set_specific(_queue, kDispatchQueueSpecificKey, (__bridge void *)self, NULL);

    self.databasePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:name];
    self.db = [[bDatabase alloc] initWithPath:self.databasePath];
}

- (void)start {
    _queue = dispatch_queue_create([[NSString stringWithFormat:@"bench.%@", self] UTF8String], NULL);
    dispatch_queue_set_specific(_queue, kDispatchQueueSpecificKey, (__bridge void *)self, NULL);

    self.databasePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[NSString stringWithFormat:@"/bench.sqlite"]];
    self.db = [[bDatabase alloc] initWithPath:self.databasePath];
}

- (BOOL)executeCustomUpdate:(NSString *)sql, ...{
    va_list args;
    va_start(args, sql);
    [self.db open];
    BOOL result = [self.db executeUpdate:sql VAList:args];
    
    va_end(args);
    
    return result;
}

- (BOOL)insert:(id)modelObject {

    if (!modelObject) return NO;

    return [self inserts:@[modelObject]];
}

- (BOOL)insert:(id)modelObject
     tableName:(NSString *)tableName {
    if (!modelObject) return NO;
    return [self inserts:@[modelObject] tableName:tableName];
}

- (BOOL)inserts:(NSArray *)modelArray {
    
    return [self inserts:modelArray tableName:nil];
}

- (BOOL)inserts:(NSArray *)modelArray
      tableName:(NSString *)tableName {
    __block BOOL result = NO;
    if (!modelArray || modelArray.count == 0) return result;
    
    dispatch_sync(self.queue, ^() {
        result = [self commonInserts:modelArray tableName:tableName];
    });
    
    return result;
}

- (BOOL)update:(id)modelObject
         where:(NSString *)where {
    return [self update:modelObject where:where tableName:nil];
}

- (BOOL)update:(id)modelObject
         where:(NSString *)where
     tableName:(NSString *)tableName {
    __block BOOL result = NO;
    if (!modelObject ) return result;
    dispatch_sync(self.queue, ^() {
        result = [self commonUpdate:modelObject where:where tableName:tableName];
    });
    return result;
}

- (BOOL)update:(Class)modelClass
         value:(NSString *)value
         where:(NSString *)where {
    if (!modelClass || !value || !value.length) return NO;
    return [self updateWithTableName:NSStringFromClass(modelClass) value:value where:where];
}

- (BOOL)updateWithTableName:(NSString *)tableName
                      value:(NSString *)value
                      where:(NSString *)where {
    
    __block BOOL result = NO;
    if (!tableName || !tableName.length|| !value || !value.length) return result;
    
    dispatch_sync(self.queue, ^() {
        result = [self commonUpdateWithTableName:tableName value:value where:where];
    });
    return result;
}

- (NSArray *)query:(Class)modelClass {
    return [self query:modelClass where:nil tableName:nil];
}

- (NSArray *)query:(Class)modelClass
         tableName:(NSString *)tableName {
    return [self query:modelClass where:nil tableName:tableName];
}

- (NSArray *)query:(Class)modelClass
             where:(NSString *)where {
    return [self query:modelClass where:where tableName:nil];;
}

- (NSArray *)query:(Class)modelClass
             where:(NSString *)where
         tableName:(NSString *)tableName {
    __block NSArray *array = [NSArray new];
    if (!modelClass) return array;
    
    dispatch_sync(self.queue, ^() {
        array = [self commonQuery:modelClass where:where orderBy:nil desc:0 limit:0 tableName:tableName];
    });
    return array;
}

- (NSArray *)query:(Class)modelClass
             where:(NSString *)where
           orderBy:(NSString *)orderBy
              desc:(BOOL)desc
             limit:(int)limit
         tableName:(NSString *)tableName {
    __block NSArray *array = [NSArray new];
    if (!modelClass) return array;
    
    dispatch_sync(self.queue, ^() {
        array = [self commonQuery:modelClass where:where orderBy:orderBy desc:desc limit:limit tableName:tableName];
    });
    return array;
}

- (BOOL)clear:(NSString *)tableName {
    return [self delete:tableName where:nil];
}

- (BOOL)delete:(NSString *)tableName
         where:(NSString *)where
       orderBy:(NSString *)orderBy
          desc:(BOOL)desc
         limit:(int)limit {
    __block BOOL result = NO;
    if (!tableName || !tableName.length) return result;
    
    dispatch_sync(self.queue, ^() {
        result = [self commonDelete:tableName where:where orderBy:orderBy desc:desc limit:limit];
    });
    return result;
}

- (BOOL)delete:(NSString *)tableName
         where:(NSString *)where {
    __block BOOL result = NO;
    if (!tableName || !tableName.length) return result;
    
    dispatch_sync(self.queue, ^() {
        result = [self commonDelete:tableName where:where orderBy:nil desc:0 limit:0];
    });
    return result;
}

- (void)removeDBFile {
    dispatch_sync(self.queue, ^() {
        NSFileManager * file_manager = [NSFileManager defaultManager];
        if ([file_manager fileExistsAtPath:self.databasePath])
        {
            [file_manager removeItemAtPath:self.databasePath error:nil];
        }
    });
}
#pragma private

- (BOOL)createTable:(Class)modelClass
          tableName:(NSString *)tableName{
    if (![self.db open]) return NO;
    
    return [self.db executeUpdate:[bDatabaseTool createTableSQL:modelClass tableName:tableName]];
}

- (BOOL)commonInserts:(NSArray *)modelArray
            tableName:(NSString *)tableName {
    __block BOOL result = NO;
    if (!modelArray || modelArray.count == 0) return result;
    
    @autoreleasepool {
        if ([self createTable:[modelArray.firstObject class] tableName:tableName])
        {
            [modelArray enumerateObjectsUsingBlock:^(id model, NSUInteger idx, BOOL * _Nonnull stop) {
                
                result = [self commonInsert:model tableName:tableName];
                if (!result) {*stop = YES;}
            }];
            [self.db close];
        }
    }
    return result;
}

- (BOOL)commonInsert:(id)modelObject
           tableName:(NSString *)tableName {
    NSDictionary *dic = [bDatabaseTool insertSQL:modelObject tableName:tableName];
    return [self.db executeUpdate:dic.allKeys.firstObject argumentsArray:dic.allValues.firstObject];
}

- (BOOL)commonUpdate:(id)modelObject
               where:(NSString *)where
           tableName:(NSString *)tableName {
    BOOL result = NO;
    NSFileManager * file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:self.databasePath])
    {
        @autoreleasepool {
            if (![self.db open]) return result;
            
            NSDictionary *dic = [bDatabaseTool updateSQL:modelObject where:where tableName:tableName];
            result = [self.db executeUpdate:dic.allKeys.firstObject argumentsArray:dic.allValues.firstObject];
            
            [self.db close];
        }
    }
    return result;
}

- (BOOL)commonUpdateWithTableName:(NSString *)tableName
                            value:(NSString *)value
                            where:(NSString *)where {

    BOOL result = NO;
    NSFileManager * file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:self.databasePath])
    {
        @autoreleasepool {
            if (![self.db open]) return result;
            
            result = [self.db executeUpdate:[bDatabaseTool updateSQLWithTableName:tableName value:value where:where]];
            [self.db close];
        }
    }
    return result;
}

- (NSArray *)commonQuery:(Class)modelClass
                   where:(NSString *)where
                 orderBy:(NSString *)orderBy
                    desc:(BOOL)desc
                   limit:(int)limit
               tableName:(NSString *)tableName {
    __block NSArray *array = [NSArray new];
    NSFileManager * file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:self.databasePath])
    {
        @autoreleasepool {
            if (![self.db open]) return array;
            NSArray *modelArray = [bDatabaseTool querySQL:modelClass where:where orderBy:orderBy desc:desc limit:limit tableName:tableName];
            if (modelArray.count == 3) {
              array = [self.db executeQuery:modelArray[0] fieldDictionary:modelArray[1] modelObject:modelArray[2]];
            }
            [self.db close];
        }
    }
    return array;
}

- (BOOL)commonDelete:(NSString *)tableName
               where:(NSString *)where
             orderBy:(NSString *)orderBy
                desc:(BOOL)desc
               limit:(int)limit {
    
    BOOL result = NO;
    NSFileManager * file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:self.databasePath])
    {
        @autoreleasepool {
            if (![self.db open]) return result;
            
            result = [self.db executeUpdate:[bDatabaseTool deleteSQL:tableName where:where orderBy:orderBy desc:desc limit:limit]];
            
            [self.db close];
        }
    }
    return result;
}

@end
