//
//  DVTagButton.h
//  Together
//
//  Created by Sergey Shpygar on 01.02.13.
//  Copyright (c) 2013 DENIVIP Media. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSTokenField;

@interface DVTokenButton : UIButton

@property (nonatomic, getter=isToggled) BOOL toggled;

@property (nonatomic, retain) id representedObject;

@property (nonatomic, weak) JSTokenField *parentField;

+ (DVTokenButton *)tokenWithString:(NSString *)string representedObject:(id)obj withNormalBg:(UIImage*)normalBg removeIcon:(UIImage*)removeIcon;

@end
