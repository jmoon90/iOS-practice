//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by John Moon on 6/14/14.
//  Copyright (c) 2014 JM. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

-(void)loadView {
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end
