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
#import "DVTogetherAppearance.h"
#import "UIImage+DVGColor.h"

static CGFloat const kBackgroundHeight = 20.f;

@interface DVTokenButton () <UIKeyInput>

@end

@implementation DVTokenButton

+ (DVTokenButton *)tokenWithString:(NSString *)string representedObject:(id)obj withNormalBg:(UIImage*)normalBg removeIcon:(UIImage *)removeIcon
{
	DVTokenButton *button = (DVTokenButton *)[self buttonWithType:UIButtonTypeCustom];
    [button configureWithString:string representedObject:obj withNormalBg:normalBg removeIcon:removeIcon];
    return button;
}

- (void)configureWithString:(NSString *)string representedObject:(id)obj withNormalBg:(UIImage *)normalBg removeIcon:(UIImage *)removeIcon
{
	[self setAdjustsImageWhenHighlighted:NO];
	[[self titleLabel] setFont:[UIFont systemFontOfSize:11.f]];
	[[self titleLabel] setLineBreakMode:NSLineBreakByTruncatingTail];
    self.contentEdgeInsets = UIEdgeInsetsMake(0.f, 8.f, 0.f, 8.f);

	[self setTitle:string forState:UIControlStateNormal];
    [self addTarget:self action:@selector(removeTag:) forControlEvents:UIControlEventTouchUpInside];
	[self setToggled:YES];
	[self setRepresentedObject:obj];
	[self sizeToFit];

    self.color = [UIColor togetherWhiteColor];
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

- (void)setColor:(UIColor *)color
{
    _color = [color copy];
	[self setTitleColor:_color forState:UIControlStateNormal];
    UIImage *backgroundImage = [[[UIImage imageNamed:@"button_tag"] dvg_imageOverlayedWithColor:_color] stretchableImageWithLeftCapWidth:12.f topCapHeight:0.f];
	[self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
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
