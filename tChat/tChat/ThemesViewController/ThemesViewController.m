//
//  ThemesViewController.m
//  tChat
//
//  Created by z on 14/10/2018.
//  Copyright © 2018 Ivan Sorokoletov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemesViewController.h"

@interface ThemesViewController()
@end

@implementation ThemesViewController

- (void)setDelegate:(id <ThemesViewControllerDelegate>) delegate {
    _delegate = delegate;
}

- (id <ThemesViewControllerDelegate>) delegate {
    return _delegate;
}

- (void) setModel:(Themes *) model {
    
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
}

- (Themes *) model {
    return _model;
}

- (IBAction)btnClosePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnTheme1Pressed:(id)sender {
    self.view.backgroundColor = self.model.theme1;
    [self.delegate themesViewController:self didSelectTheme:self.model.theme1];
}
- (IBAction)btnTheme2Pressed:(id)sender {
    self.view.backgroundColor = self.model.theme2;
    [self.delegate themesViewController:self didSelectTheme:self.model.theme2];
}
- (IBAction)btnTheme3Pressed:(id)sender {
    self.view.backgroundColor = self.model.theme3;
    [self.delegate themesViewController:self didSelectTheme:self.model.theme3];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.model = [[[Themes alloc] init] autorelease];
    
}

- (void)dealloc {
    
    [_model release];
    [super dealloc];
}

@end






