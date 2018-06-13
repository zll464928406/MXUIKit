//
//  MXUISlider.m
//  MXUIKit
//
//  Created by sunny on 2018/6/13.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "MXUISlider.h"
#import "MXUISliderCell.h"

@implementation MXUISlider

+ (Class)cellClass
{
    return [MXUISliderCell class];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end
