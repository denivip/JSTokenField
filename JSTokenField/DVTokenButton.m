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

@interface DVTokenButton ()

@property (nonatomic, strong) UIButton *removeButton;

@end

@implementation DVTokenButton

+ (DVTokenButton *)tokenWithString:(NSString *)string representedObject:(id)obj withNormalBg:(UIImage*)normalBg removeIcon:(UIImage *)removeIcon
{
	DVTokenButton *button = (DVTokenButton *)[self buttonWithType:UIButtonTypeCustom];
	[button setAdjustsImageWhenHighlighted:NO];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[[button titleLabel] setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
	[[button titleLabel] setLineBreakMode:UILineBreakModeTailTruncation];
	[button setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
	[button setBackgroundImage:normalBg forState:UIControlStateNormal];
    
	[button setTitle:string forState:UIControlStateNormal];
	
	[button sizeToFit];
	CGRect frame = [button frame];
	frame.size.width += 34;
	frame.size.height = 22;
	[button setFrame:frame];
	
    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeButton setImage:removeIcon forState:UIControlStateNormal];
    [removeButton setFrame:CGRectMake(frame.size.width - frame.size.height, 0,  frame.size.height,  frame.size.height)];
    [removeButton addTarget:button action:@selector(removeTag:) forControlEvents:UIControlEventTouchUpInside];
    button.removeButton = removeButton;
    [removeButton setHidden:YES];
    [button addSubview:removeButton];
	[button setToggled:NO];
	
	[button setRepresentedObject:obj];
	
	return button;
}

- (void)setToggled:(BOOL)toggled
{
	_toggled = toggled;
	[self.removeButton setHidden:!toggled];
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
    return YES;
}

@end
