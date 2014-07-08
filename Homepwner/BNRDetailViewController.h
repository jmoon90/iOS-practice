//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by John Moon on 6/10/14.
//  Copyright (c) 2014 BNR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController

-(instancetype)initForNewItem:(BOOL)isNew;
@property (nonatomic, strong) BNRItem *item;
@property(nonatomic, copy)void (^dismissBlock)(void);

@end
