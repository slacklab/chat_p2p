//
//  Themes.h
//  tChat
//
//  Created by z on 14/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

#ifndef Themes_h
#define Themes_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Themes: NSObject {
    
    UIColor* _theme1;
    UIColor* _theme2;
    UIColor* _theme3;
    
}

@property (strong, nonatomic, nullable) UIColor* theme1;
@property (strong, nonatomic, nullable) UIColor* theme2;
@property (strong, nonatomic, nullable) UIColor* theme3;

@end

NS_ASSUME_NONNULL_END

#endif /* Themes_h */






