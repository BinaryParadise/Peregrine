//
//  PGRouterManager.h
//  Peregrine
//
//  Created by Rake Yang on 2019/5/6.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGRouterNode.h"

#define PGTarget(_router) __attribute__((pe_routed(_router)))
#define PGMethod(_name, _url) \
+ (void)_name:(nullable PGRouterContext *)context PGTarget(_url) \

@interface PGRouterManager<__covariant ObjectType> : NSObject

+ (NSDictionary<NSString *, PGRouterNode *> *)routerMap;

/**
 Open a URLString that you have registered in this manager.

 @param URLString The URL string with which to initialize the NSURL object. Must be a URL that conforms to RFC 2396. This method parses URLString according to RFCs 1738 and 1808.
 @param completion callback
 */
+ (void)openURL:(NSString *)URLString completion:(void (^)(BOOL ret, ObjectType object))completion;

/**
Open a URLString that you have registered in this manager.

@param URLString The URL string with which to initialize the NSURL object. Must be a URL that conforms to RFC 2396. This method parses URLString according to RFCs 1738 and 1808.
@param object object
@param completion callback
*/
+ (void)openURL:(NSString *)URLString object:(id)object completion:(void (^)(BOOL ret, ObjectType object))completion;

/**
 Verify the url is correct

 @param URLString The URL string with which to initialize the NSURL object. Must be a URL that conforms to RFC 2396. This method parses URLString according to RFCs 1738 and 1808.
 */
+ (BOOL)dryRun:(NSString *)URLString;

@end
