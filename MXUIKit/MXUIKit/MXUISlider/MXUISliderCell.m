//
//  MXUISliderCell.m
//  MXUIKit
//
//  Created by sunny on 2018/6/13.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "MXUISliderCell.h"

#ifndef NSCOLOR
#define NSCOLOR(r, g, b, a) [NSColor colorWithCalibratedRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#endif

@implementation MXUISliderCell
- (NSRect)knobRectFlipped:(BOOL)flipped
{
    NSRect knobRect = [super knobRectFlipped:flipped];
    knobRect.origin.x += 6;
    knobRect.origin.y += 7.5;
    knobRect.size.height = 8;
    knobRect.size.width = 8;
    return knobRect;
}


- (void)drawKnob:(NSRect)knobRect
{
    NSColor *color = [NSColor orangeColor];
    NSBezierPath *outerPath = [NSBezierPath bezierPathWithOvalInRect:knobRect];
    NSGradient *outerGradient = [[NSGradient alloc] initWithColors:@[color, color]];
    [outerGradient drawInBezierPath:outerPath angle:90];
    NSBezierPath *innerPath = [NSBezierPath bezierPathWithOvalInRect:NSInsetRect(knobRect, 2, 2)];
    NSGradient *innerGradient = [[NSGradient alloc] initWithColors:@[color, color]];
    [innerGradient drawInBezierPath:innerPath angle:90];
}


- (void)drawBarInside:(NSRect)aRect flipped:(BOOL)flipped
{
    NSRect sliderRect = aRect;
    if (NSAppKitVersionNumber >= 1265)
    {
        sliderRect.origin.y += (NSMaxY(sliderRect) / 2) - 8;
    }
    else
    {
        sliderRect.origin.y += (NSMaxY(sliderRect) / 2) - 4;
    }
    
    sliderRect.origin.x += 2;
    sliderRect.size.width -= 4;
    sliderRect.size.height = 11;
    
    
    CGFloat SlectedWidth = self.doubleValue == 0 ? 0.01 : sliderRect.size.width*self.doubleValue;
    CGRect slectedRect = CGRectMake(sliderRect.origin.x, sliderRect.origin.y, SlectedWidth, sliderRect.size.height);
    
    CGRect otherRect = CGRectMake(sliderRect.origin.x, sliderRect.origin.y, sliderRect.size.width-SlectedWidth, sliderRect.size.height);
    
    // selected color
    NSColor *color = [NSColor blueColor];
    NSBezierPath *barPath = [NSBezierPath bezierPathWithRoundedRect:slectedRect xRadius:4 yRadius:4];
    NSGradient *borderGradient = [[NSGradient alloc] initWithColors:@[color, color]];
    [borderGradient drawInBezierPath:barPath angle:90];
    NSBezierPath *innerPath = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(slectedRect, 1, 1) xRadius:4 yRadius:4];
    [color setFill];
    [innerPath fill];
    
//    // other color
//    NSColor *otherColor = [NSColor darkGrayColor];
//    
//    NSBezierPath *otherbarPath = [NSBezierPath bezierPathWithRoundedRect:otherRect xRadius:4 yRadius:4];
//    NSGradient *otherborderGradient = [[NSGradient alloc] initWithColors:@[otherColor, otherColor]];
//    [borderGradient drawInBezierPath:otherbarPath angle:90];
//    NSBezierPath *otherinnerPath = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(otherRect, 1, 1) xRadius:4 yRadius:4];
//    [otherColor setFill];
//    [otherinnerPath fill];
}
@end
