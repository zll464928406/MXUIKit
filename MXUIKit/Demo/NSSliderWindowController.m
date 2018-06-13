//
//  NSSliderWindowController.m
//  MXUIKit
//
//  Created by sunny on 2018/6/13.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "NSSliderWindowController.h"
#import "MXUISlider.h"
#import "Masonry.h"

@interface NSSliderWindowController ()

@property (nonatomic, strong) MXUISlider *slider;

@end

@implementation NSSliderWindowController
-(NSNibName)windowNibName
{
    return NSStringFromClass(self.class);
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    self.slider = [[MXUISlider alloc] init];
    [self.slider setTrackFillColor:[NSColor orangeColor]];
//    self.slider.backgroundColor = [NSColor orangeColor];
    [self.window.contentView addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200.0f);
        make.height.mas_equalTo(20.0f);
        make.center.equalTo(self.window.contentView);
    }];
}

@end
