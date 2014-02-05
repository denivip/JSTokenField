//
//  DVTagButton.m
//  Together
//
//  Created by Sergey Shpygar on 01.02.13.
//  Copyright (c) 2013 DENIVIP Media. All rights reserved.
//

#import "DVTokenButton.h"
#import <QuartzCore/QuartzCore.h>
#import "JSTokenField.h"
#import "DVTogetherAppearance.h"
#import "UIImage+DVGColor.h"

static CGFloat const kBackgroundHeight = 20.f;

@interface DVTokenButton () <UIKeyInput>

@end

@implementation DVTokenButton

+ (DVTokenButton *)tokenWithString:(NSString *)string representedObject:(id)obj withNormalBg:(UIImage*)normalBg removeIcon:(UIImage *)removeIcon
{
    srand([string length]);
    CGFloat hue = (CGFloat)(rand() % 10) / 9.f;
    // Исключаем слишком синие цвета 194°..294°, так как их плохо видно на фоне.
    if (hue > 194.f/360.f && hue < 294.f/360.f) {
        hue -= (294.f - 194.f) / 360.f;
    }
    UIColor *color = [UIColor colorWithHue:hue saturation:1.f brightness:1.f alpha:1.f];

	DVTokenButton *button = (DVTokenButton *)[self buttonWithType:UIButtonTypeCustom];
	[button setAdjustsImageWhenHighlighted:NO];
	[button setTitleColor:color forState:UIControlStateNormal];
	[[button titleLabel] setFont:[UIFont systemFontOfSize:11.f]];
	[[button titleLabel] setLineBreakMode:NSLineBreakByTruncatingTail];
    button.contentEdgeInsets = UIEdgeInsetsMake(0.f, 8.f, 0.f, 8.f);

    UIImage *backgroundImage = [[[UIImage imageNamed:@"button_tag"] dvg_imageOverlayedWithColor:color] stretchableImageWithLeftCapWidth:12.f topCapHeight:0.f];
	[button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
	[button setTitle:string forState:UIControlStateNormal];
    [button addTarget:button action:@selector(removeTag:) forControlEvents:UIControlEventTouchUpInside];
	[button setToggled:YES];
	[button setRepresentedObject:obj];
	[button sizeToFit];

	return button;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.width = MIN(size.width, sizeThatFits.width);
    sizeThatFits.height = kBackgroundHeight;

    return sizeThatFits;
}

- (void)removeTag:(UIButton*)sender {
    [self.parentField removeTokenForString:[self titleForState:UIControlStateNormal]];
}

#pragma mark - UIKeyInput
- (void)deleteBackward {
    [self.parentField removeTokenForString:[self titleForState:UIControlStateNormal]];
}

- (BOOL)hasText {
    return NO;
}

- (void)insertText:(NSString *)text {
    return;
}


- (BOOL)canBecomeFirstResponder {
    return NO;
}

@end
