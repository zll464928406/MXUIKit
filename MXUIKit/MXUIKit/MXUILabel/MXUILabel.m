//
//  MXUILabel.m
//  MXUIKit
//
//  Created by sunny on 2018/6/1.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "MXUILabel.h"

@implementation MXUILabel
- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self setBezeled:NO];
//    [self setDrawsBackground:NO];
    [self setEditable:NO];
    [self setSelectable:NO];
    [[self cell] setLineBreakMode:NSLineBreakByTruncatingTail];
//    self.attributedString = nil;
    self.underlined = NO;
}

@end
