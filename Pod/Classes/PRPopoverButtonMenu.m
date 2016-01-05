//
//  PRPopoverButtonMenu.m
//  TestGesture
//
//  Created by Patrick Ryan on 10/31/15.
//  Copyright © 2015 Patrick. All rights reserved.
//

#import "PRPopoverButtonMenu.h"
#import "PRCoordinateManager.h"
#import "PRButtonManager.h"

@interface PRPopoverButtonMenu ()
@property (nonatomic,strong) PRButtonMenu *buttonMenu;
@property UIView *background;
@property UIView * superView;
@property NSInteger offset;
@end

@implementation PRPopoverButtonMenu

-(id)initWithFrame:(CGRect)frame withButtons:(NSArray *)buttons helpText:(NSArray *)helpText controller:(UICollectionViewController *) controller withOffset:(NSInteger)offset labelSize:(CGSize)size withRadius:(NSInteger)radius angleScaler:(double)scaler initialThetaOffset:(double)theta{

    self = [super initWithFrame:frame];
    if(self){
        self.clipsToBounds = NO;
        if (!self.longPressReconizer) {
        
            self.longPressReconizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
            self.background = [[UIView alloc]initWithFrame:frame];
            self.buttonMenu = [[PRButtonMenu alloc]initWithFrame:frame withButtons:buttons helperText:helpText withLabelSize:size];
            
            self.superView = controller.view;
            self.buttonMenu.delegate = self;
            self.buttonMenu.viewToReturnCoords = controller.collectionView;
            
            self.longPressReconizer.delaysTouchesBegan = YES;
            self.longPressReconizer.minimumPressDuration = 0.5;
            self.buttonMenu.offset = offset;
            
            self.buttonMenu.coordinateManager.radius = radius;
            self.buttonMenu.coordinateManager.angleSpace = scaler;
            self.buttonMenu.coordinateManager.initialTheta =  theta;
        }
    }
    return self;
}

-(IBAction)longPress:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:self.superView];
        BOOL shouldShow =  [self.delegate buttonMenu:self shouldShowAtPoint:[recognizer locationInView:self.buttonMenu.viewToReturnCoords]];
        if (shouldShow) {
            [self addButtonMenuWithCoord:point];
        }else{
            recognizer.enabled = NO;
            recognizer.enabled = YES;
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged){
        CGPoint point = [recognizer locationInView:self.superView];
        [self.buttonMenu highlightButton:point];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [recognizer locationInView:self.superView];
        [self.buttonMenu retrieveHighlightedButton:point];
        [self removeButtonMenu];
    }
}

-(void)addButtonMenuWithCoord:(CGPoint)coords{
    [self.background setFrame:self.superView.frame];
    [self.superView addSubview:self.background];
    [self.superView addSubview:self.buttonMenu];
    [self.buttonMenu setCoords:coords];
    [self.background setBackgroundColor:[UIColor colorWithWhite:.1 alpha:.2]];
}

-(void)removeButtonMenu{
    [self.background removeFromSuperview];
    [self.buttonMenu remove];
}

-(void)buttonAtIndex:(NSInteger)index pushedAt:(CGPoint)point{
    [self.delegate buttonAtIndex:self didSelectButton:index atPoint:point];
}


@end
