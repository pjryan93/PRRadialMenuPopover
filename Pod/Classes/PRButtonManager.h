//
//  PRButton.h
//  TestGesture
//
//  Created by Patrick Ryan on 11/5/15.
//  Copyright © 2015 Patrick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRButtonManager : NSObject

@property BOOL isSelectable;
@property BOOL isClosest;
@property BOOL shouldAnimateBackwords;

@property UIButton *button;
@property UIView *helpLabel;
@property UIColor *buttonBackgroundColor;

-(id)initWithButton:(UIButton *)buttonInput andLabel:(UILabel *)label;
-(void)positionLabel;
-(void)highlight;
-(void)setNormal;
@end
