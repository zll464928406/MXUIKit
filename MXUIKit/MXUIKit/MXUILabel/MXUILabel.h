//
//  MXUILabel.h
//  MXUIKit
//
//  Created by sunny on 2018/6/1.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MXUILabel : NSTextField

@property (nonatomic, assign, readonly) int widthOfText;
@property (nonatomic, assign, readonly) int heightOfText;
@property (nonatomic, assign) BOOL underlined;

-(void)setStringValue:(NSString *)stringValue;
-(NSString *)stringValue;
-(void)setAttributedStringValue:(NSAttributedString *)attributedStringValue;
-(NSAttributedString *)attributedStringValue;

@end
