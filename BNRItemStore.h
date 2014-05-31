//
//  BNRItemStore.h
//  Homepwner
//
//  Created by John Moon on 5/31/14.
//  Copyright (c) 2014 BNR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly)NSArray *allItems;

+(instancetype)sharedStore;
-(BNRItem *)createItem;

@end
