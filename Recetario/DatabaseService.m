//
//  DatabaseService.m
//  DemoResults
//
//  Created by Emiliano Galitiello on 6/29/13.
//  Copyright (c) 2013 bka. All rights reserved.
//

#import "DatabaseService.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

#define kDatabaseName @"ios.db"


static NSString *kDatabasePath;
static NSString *kSelectFromTableFormat = @"SELECT * FROM %@;";
static NSString *kSelectFromTableWhereFormat = @"SELECT * FROM %@ WHERE %@;";

// unused string
static NSString *kInsertOnTableFormat = @"INSERT INTO %@ (%@) VALUES (%@);";
static NSString *kUpdateOnTableFormat = @"UPDATE %@ SET %@ WHERE %@ = %i;";

@implementation DatabaseService

+(void)createAndCheckDatabase
{    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    kDatabasePath = [documentDir stringByAppendingPathComponent:kDatabaseName];
    
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:kDatabasePath];
    
    if(success) return;
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDatabaseName];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:kDatabasePath error:nil];
}

+ (void)performSelectOnTable:(NSString*)table withParameters:(NSString*)parameters withResultBlock:(DatabaseServiceResultBlock)block completionBlock:(DatabaseServiceCompletionBlock)completionBlock
{
    FMDatabase *db = [FMDatabase databaseWithPath:kDatabasePath];
    
    [db open];
    
    NSString *query = [NSString stringWithFormat:kSelectFromTableFormat, table];
    if (parameters != nil) {
        query = [NSString stringWithFormat:kSelectFromTableWhereFormat, table, parameters];
    }
    
    FMResultSet *results = [db executeQuery:query];
    
    while([results next])
    {
        block(results);
    }
    completionBlock();
    [db close];
}

+ (void)performBulkInsert:(NSArray*)objects onTable:(NSString*)table clearTable:(BOOL)clear
{
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:kDatabasePath];
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL success = true;
        if (clear) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE from %@", table], nil];
        }
        for (id object in objects) {
            NSDictionary *dict = object;
            if ([object conformsToProtocol:@protocol(DatabaseObject)]) {
                dict = [object objectToDict];
            }
            success = [DatabaseService performInsert:dict onTable:table andDatabase:db];
        }
        if (!success) {
            NSLog(@"bulk insert failed: %@", [db lastError]);
        }
    }];
}

+ (BOOL)performSimpleInsert:(NSDictionary*)object onTable:(NSString*)table
{
    FMDatabase *db = [FMDatabase databaseWithPath:kDatabasePath];
    
    [db open];
    BOOL success = [self performInsert:object onTable:table andDatabase:db];
    [db close];
    return success;
}

+ (BOOL)performInsert:(NSDictionary*)object onTable:(NSString*)table andDatabase:(FMDatabase*)db
{
    NSArray *allKeys = [object allKeys];
    NSMutableArray *valuesStrings = [NSMutableArray arrayWithCapacity:[allKeys count]];
    for (NSString *key in allKeys) {
        [valuesStrings addObject:[NSString stringWithFormat:@":%@", key]];
    }
    NSString *keysString = [allKeys componentsJoinedByString:@","];
    NSString *valuesString = [valuesStrings componentsJoinedByString:@","];
    
    NSString *queryString = [NSString stringWithFormat:kInsertOnTableFormat, table, keysString, valuesString];
    BOOL success =  [db executeUpdate:queryString withParameterDictionary:object];
    return success;
}

+ (BOOL)performUpdate:(NSDictionary*)object onTable:(NSString*)table withIdKey:(NSString*)idKey
{
    FMDatabase *db = [FMDatabase databaseWithPath:kDatabasePath];
    
    [db open];
    
    NSArray *allKeys = [object allKeys];
    NSMutableArray *keysStrings = [NSMutableArray arrayWithCapacity:[allKeys count]];
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:[allKeys count]];
    for (NSString *key in allKeys) {
        [values addObject:[object objectForKey:key]];
        [keysStrings addObject:[NSString stringWithFormat:@"%@ = ?", key]];
    }
    NSString *keysString = [keysStrings componentsJoinedByString:@","];
    NSString *queryString = [NSString stringWithFormat:kUpdateOnTableFormat, table, keysString, idKey, [[object objectForKey:idKey] intValue]];
    BOOL success =  [db executeUpdate:queryString withArgumentsInArray:values];
    
    [db close];
    return success;
}

+ (BOOL)performDeleteFromTable:(NSString*)table withId:(int)identifier andIdKey:(NSString*)idKey
{
    FMDatabase *db = [FMDatabase databaseWithPath:kDatabasePath];
    
    [db open];
    
    NSString *queryString = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?", table, idKey];
    NSArray *values = [NSArray arrayWithObject:[NSNumber numberWithInt:identifier]];
    BOOL success =  [db executeUpdate:queryString withArgumentsInArray:values];
    
    [db close];
    return success;
}

@end
