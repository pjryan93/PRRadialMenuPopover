//
//  PRPopoverButtonMenu.h
//  TestGesture
//
//  Created by Patrick Ryan on 10/31/15.
//  Copyright © 2015 Patrick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PRButtonMenu.h"

@class PRPopoverButtonMenu;

@protocol PRPopoverMenuDelegate <NSObject>

@required
- (void) buttonAtIndex:(PRPopoverButtonMenu *)buttonManager didSelectButton:(NSInteger)index atPoint:(CGPoint)point;
- (BOOL) buttonMenu:(PRPopoverButtonMenu*)buttonMenu shouldShowAtPoint:(CGPoint)point;

@end


@interface PRPopoverButtonMenu : UIView <ButtonPushDelegate>

@property (nonatomic,strong) UILongPressGestureRecognizer *longPressReconizer;
@property (nonatomic,weak) id <PRPopoverMenuDelegate> delegate;

-(id)initWithFrame:(CGRect)frame withButtons:(NSArray *)buttons helpText:(NSArray *)helpText controller:(UICollectionViewController *) controller withOffset:(NSInteger)offset labelSize:(CGSize)size withRadius:(NSInteger)radius angleScaler:(double)scaler initialThetaOffset:(double)theta;

@end
