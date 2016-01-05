//
//  PRButtonMenu.h
//  TestGesture
//
//  Created by Patrick Ryan on 10/31/15.
//  Copyright © 2015 Patrick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRButtonManager.h"
#import "PRCoordinateManager.h"

@protocol ButtonPushDelegate <NSObject>
-(void)buttonAtIndex:(NSInteger)index pushedAt:(CGPoint)point;
@end

@interface PRButtonMenu : UIView
@property NSArray *menuButtons;
@property UIView * viewToReturnCoords;
@property  UIButton *closestButton;
@property NSInteger offset;
@property (nonatomic,weak) id <ButtonPushDelegate> delegate;
@property PRCoordinateManager *coordinateManager;

-(id)initWithFrame:(CGRect)frame withButtons:(NSArray *)buttonArray helperText:(NSArray *)textArray withLabelSize:(CGSize)size;
-(void)setCoords:(CGPoint)coords;
-(void)retrieveHighlightedButton:(CGPoint)coords;
-(void)highlightButton:(CGPoint)coords;
-(void)remove;


@end
