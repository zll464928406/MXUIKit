//
//  LabelWindowController.m
//  MXUIKit
//
//  Created by sunny on 2018/6/11.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "LabelWindowController.h"
#import "MXUILabel.h"
#import "Masonry.h"

@interface LabelWindowController ()

@property (nonatomic, strong) MXUILabel *label;

@end

@implementation LabelWindowController

-(NSNibName)windowNibName
{
    return NSStringFromClass(self.class);
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    self.label = [[MXUILabel alloc] init];
    
    self.label.stringValue = @"123456789";
    self.label.backgroundColor = [NSColor orangeColor];
    [self.window.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200.0f);
        make.height.mas_equalTo(50.0f);
        make.center.equalTo(self.window.contentView);
    }];
}

@end
