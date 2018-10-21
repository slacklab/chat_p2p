//
//  ThemesViewController.h
//  tChat
//
//  Created by z on 14/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

#ifndef ThemesViewController_h
#define ThemesViewController_h


#import <UIKit/UIKit.h>
#import "Themes.h"

NS_ASSUME_NONNULL_BEGIN

@class ThemesViewController;

@protocol ThemesViewControllerDelegate <NSObject>

- (void) themesViewController: (ThemesViewController *) controller didSelectTheme: (UIColor *) selectedTheme;

@end

@interface ThemesViewController : UIViewController {
    
    id <ThemesViewControllerDelegate> _delegate;
    Themes * _model;
    
}

@property (weak, nonatomic) id <ThemesViewControllerDelegate> delegate;
@property (strong, nonatomic) Themes * model;

- (void) setDelegate: (id <ThemesViewControllerDelegate> _Nullable) delegate;
- (id <ThemesViewControllerDelegate>) delegate;

- (void) setModel: (Themes * _Nonnull) model;
- (Themes*) model;

@end

NS_ASSUME_NONNULL_END

#endif /* ThemesViewController_h */

