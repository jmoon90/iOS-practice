//
//  BNRImageStore.m
//  Homepwner
//
//  Created by John Moon on 6/13/14.
//  Copyright (c) 2014 BNR. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore();

@property(nonatomic, strong)NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

+(instancetype)sharedStore {
    static BNRImageStore *sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    return sharedStore;
}

//No one should call init
-(instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [BNRImageStore sharedStore]" userInfo:nil];
    return nil;
}

//Secret designated initializer
-(instancetype)initPrivate {
    self = [super init];
    
    if(self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image;
}

-(UIImage *)imageForKey:(NSString *)key {
    return self.dictionary[key];
}

-(void)deleteImageForKey:(NSString *)key {
    [self.dictionary removeObjectForKey:key];
}
@end
