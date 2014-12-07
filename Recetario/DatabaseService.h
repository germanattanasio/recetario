//
//  DatabaseService.h
//  DemoResults
//
//  Created by Emiliano Galitiello on 6/29/13.
//  Copyright (c) 2013 bka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

typedef void(^DatabaseServiceResultBlock)(FMResultSet* resultSet);
typedef void(^DatabaseServiceCompletionBlock)();

static id ObjectOrNull (id object) {return object ? object : [NSNull null];}

@protocol DatabaseObject

- (NSDictionary*)objectToDict;

@end

@interface DatabaseService : NSObject

+ (void)createAndCheckDatabase;
+ (void)performSelectOnTable:(NSString*)table withParameters:(NSString*)parameters withResultBlock:(DatabaseServiceResultBlock)block completionBlock:(DatabaseServiceCompletionBlock)completionBlock;
+ (BOOL)performSimpleInsert:(NSDictionary*)object onTable:(NSString*)table;
+ (void)performBulkInsert:(NSArray*)objects onTable:(NSString*)table clearTable:(BOOL)clear;
+ (BOOL)performUpdate:(NSDictionary*)object onTable:(NSString*)table withIdKey:(NSString*)idKey;
+ (BOOL)performDeleteFromTable:(NSString*)table withId:(int)identifier andIdKey:(NSString*)idKey;

@end
