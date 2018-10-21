//
//  Themes.m
//  tChat
//
//  Created by z on 14/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Themes.h"

@implementation Themes

- (Themes*) init {
    [super init];
    
    _theme1 = UIColor.lightGrayColor;
    _theme2 = UIColor.darkGrayColor;
    _theme3 = UIColor.orangeColor;
    
    return self;
}

- (UIColor*) theme1 {
    return _theme1;
}

- (UIColor*) theme2 {
    return _theme2;
}

-(UIColor*) theme3 {
    return _theme3;
}

- (void)dealloc {
    
    [_theme1 release];
    [_theme2 release];
    [_theme3 release];
    [super dealloc];
    
}

@end
