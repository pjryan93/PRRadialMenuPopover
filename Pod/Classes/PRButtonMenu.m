//
//  PRButtonMenu.m
//  TestGesture
//
//  Created by Patrick Ryan on 10/31/15.
//  Copyright © 2015 Patrick. All rights reserved.
//

#import "PRButtonMenu.h"

@interface PRButtonMenu () 
@property UIView *circle;
@property (nonatomic,strong) NSArray* buttonText;
@property UIView * innercircle;
@end

@implementation PRButtonMenu

-(id)initWithFrame:(CGRect)frame withButtons:(NSArray *)buttonArray helperText:(NSArray *)textArray withLabelSize:(CGSize)size{
    self = [super initWithFrame:frame];
    if (self) {
    
        NSMutableArray *helpText = [[NSMutableArray alloc]init];
        for (NSString *label in textArray) {
             UILabel *helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
             [helpLabel setBackgroundColor:[UIColor blackColor]];
             [helpLabel setTextColor:[UIColor whiteColor]];
             helpLabel.textAlignment = NSTextAlignmentCenter;
             [helpLabel setFont:[UIFont systemFontOfSize:12]];
             helpLabel.text = label;
             helpLabel.layer.cornerRadius = 7.0f;
             helpLabel.layer.masksToBounds = YES;
             helpLabel.layer.borderColor=[UIColor whiteColor].CGColor;
             [helpText addObject:helpLabel];
        }
        
        NSMutableArray * menuButtonArrayTemp = [[NSMutableArray alloc]init];
        for(NSInteger i = 0;i < [buttonArray count];i++){
            PRButtonManager * buttonManager = [[PRButtonManager alloc]initWithButton:buttonArray[i] andLabel:helpText[i]];
            [menuButtonArrayTemp addObject:buttonManager];
        }
        
        self.coordinateManager = [[PRCoordinateManager alloc]init];
        self.menuButtons = [menuButtonArrayTemp copy];
        PRButtonManager *buttonManager = [self.menuButtons firstObject];
        self.coordinateManager.buttonSize = buttonManager.button.frame.size.width;
        self.buttonText = [helpText copy];
    }
    
    return self;
}

-(void)setCoords:(CGPoint)coords{
    
    self.coordinateManager.counter = 0;
    
    self.circle = [[UIView alloc] initWithFrame:CGRectMake(coords.x-self.coordinateManager.radius, coords.y-self.coordinateManager.radius, self.coordinateManager.radius*2, self.coordinateManager.radius*2)];
    [self.circle.layer setCornerRadius:self.circle.frame.size.width / 2];
    [self.circle setBackgroundColor:[UIColor redColor]];
    self.innercircle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (self.coordinateManager.radius*2)-(self.coordinateManager.radius/8), (self.coordinateManager.radius*2)-(self.coordinateManager.radius/8))];
    
    self.innercircle.center = self.circle.center;
    [self.innercircle.layer setCornerRadius:self.circle.frame.size.width /2];
    [self.innercircle setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:self.circle];
    [self addSubview:self.innercircle];
    
    for (PRButtonManager *buttonManager in self.menuButtons) {
        [self addSubview:buttonManager.button];
    }
    
    PRButtonManager *buttonManger = [self.menuButtons firstObject];
    double distanceToFlipArcDirection = self.coordinateManager.radius+ self.offset + buttonManger.button.frame.size.height/2 + ( buttonManger.button.frame.size.height/2);
    
    NSArray *points = [self.coordinateManager arcPointArrayAtCenter:self.circle.center numberOfPoints:[self.menuButtons count]];
    
    //direction of arc
    NSInteger x_direction = 1;
    NSInteger y_direction = 1;
    
    if (coords.x  > self.frame.size.width/2) {
    
        x_direction = -1;

        // swap the array to keep the buttons in order.
        points = [[points reverseObjectEnumerator] allObjects];
    }

    /*
        Flip vertical direction of the arc if the label can not be displayed
        even after scaling away from the frames border.
    */
    
    if (coords.y >  distanceToFlipArcDirection) {
            y_direction = -1;
    }
    
    for (PRButtonManager *buttonView in self.menuButtons) {
        CGRect buttonFrame = buttonView.button.frame;
        buttonFrame.origin = coords;
        buttonFrame.origin.x = buttonFrame.origin.x - buttonFrame.size.width/2;
        buttonFrame.origin.y = buttonFrame.origin.y - buttonFrame.size.height/2;
        [buttonView.button setFrame:buttonFrame];
    }
  
    [UIView animateWithDuration:0.15f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        NSInteger i = 0;
        for (PRButtonManager *button in self.menuButtons) {
            CGRect frame = button.button.frame;
            CGPoint point = [[points objectAtIndex:i] CGPointValue];
            frame.origin.x = frame.origin.x + (x_direction * point.x);
            frame.origin.y = frame.origin.y + (y_direction * point.y);
            [button.button setFrame:frame];
            i++;
        }
        
        const CGFloat scale = .2;
        [self.innercircle setTransform:CGAffineTransformMakeScale(scale, scale)];
        [self.circle setTransform:CGAffineTransformMakeScale(scale, scale)];
    }completion:^(BOOL completed){
        if (completed) {
            
            for (NSInteger i = 0; i < [self.menuButtons count]; i++) {
                PRButtonManager *buttonManager = self.menuButtons[i];
                [buttonManager positionLabel];
                [buttonManager.helpLabel setHidden:YES];
                [self addSubview:buttonManager.helpLabel];
                
                if (buttonManager.helpLabel.frame.origin.y - buttonManger.button.frame.size.width < self.offset) {
                  buttonManager.shouldAnimateBackwords = YES;
                }else{
                  buttonManager.shouldAnimateBackwords = NO;
                }
            }
            
             self.coordinateManager.center = self.circle.center;
            [self.innercircle setBackgroundColor:[UIColor colorWithWhite:.8 alpha:.1]];
            [self.circle setBackgroundColor:[UIColor colorWithWhite:.1 alpha:.4]];
        }
    }];
    
}

-(void)moveButton:(PRButtonManager *)buttonManager toward:(double)angle coords:(CGPoint)coords{
    
    double initialDirectionOfAnimation = 1;
    if (buttonManager.shouldAnimateBackwords) {
        initialDirectionOfAnimation = -1;
    }
    PRCoordinateManager *labelCoordinateManger = [[PRCoordinateManager alloc]init];
    
    labelCoordinateManger.radius = self.coordinateManager.radius + buttonManager.button.frame.size.width * self.coordinateManager.scale;
    labelCoordinateManger.angleSpace = self.coordinateManager.angleSpace;
    labelCoordinateManger.center = CGPointMake(self.coordinateManager.center.x,self.coordinateManager.center.y - buttonManager.button.frame.size.width/2);
    
    
    //origin does change with affine tranforms
    //frame.center does not
    //we have to manually get the center
    double x = buttonManager.button.frame.origin.x + buttonManager.button.frame.size.width/2 * self.coordinateManager.scale;
    double y = buttonManager.button.frame.origin.y + buttonManager.button.frame.size.height/2  * self.coordinateManager.scale;
    NSDictionary *buttonTransformValues = [self.coordinateManager incrementAndScaleValueToTransfromCenter:coords direction:angle centerOfViewToTransfer:CGPointMake(x, y)];
    
    double xIncrement = [buttonTransformValues[@"xIncrement"] doubleValue] * initialDirectionOfAnimation;
    double yIncrement = [buttonTransformValues[@"yIncrement"] doubleValue] * initialDirectionOfAnimation;
    
    [UIView animateWithDuration:.5f delay:.0f usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
    
            CGAffineTransform translate = CGAffineTransformMakeTranslation(xIncrement,yIncrement);
            CGAffineTransform scale = CGAffineTransformMakeScale([buttonTransformValues[@"scale"] doubleValue], [buttonTransformValues[@"scale"] doubleValue]);
            double center = buttonManager.button.frame.origin.x + buttonManager.button.frame.size.width/2 - buttonManager.helpLabel.frame.size.width/2;
        
            CGRect buttonRect = CGRectMake(center ,buttonManager.button.frame.origin.y - buttonManager.button.frame.size.width/3, buttonManager.helpLabel.frame.size.width,buttonManager.helpLabel.frame.size.height);
        
            buttonManager.button.transform = CGAffineTransformConcat(translate, scale);
            [buttonManager.helpLabel setFrame:buttonRect];
    
        
        }completion:^(BOOL completed){
             self.coordinateManager.scale = [buttonTransformValues[@"scale"] doubleValue];
    }];
}

-(void)moveButtonBack:(UIButton *)button{

    UIButton *weakButton = button;

    [UIView animateWithDuration:.5f delay:.0f usingSpringWithDamping:.5 initialSpringVelocity:.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
             [weakButton setTransform:CGAffineTransformIdentity];
      }completion:^(BOOL completed){
             self.coordinateManager.scale = 1;
        }];
}
#pragma
-(void)highlightButton:(CGPoint)coords{
    NSInteger index = [self.coordinateManager closestIndexFromPoint:coords toPoints:[self getPointArray]];
    PRButtonManager *buttonManger = self.menuButtons[index];
    CGPoint closestButtonCoords = buttonManger.button.center;
    if ([self.coordinateManager isInsideArcFromCenter:self.circle.center closestButtonCoords:closestButtonCoords pointTouched:coords]) {
    
        NSInteger index = [self.coordinateManager closestIndexFromPoint:coords toPoints:[self getPointArray]];
        PRButtonManager *buttonManager = self.menuButtons[index];
        buttonManager.isClosest = YES;
        
        for (PRButtonManager * bManager in self.menuButtons) {
            if (bManager.isClosest && bManager != buttonManager) {
                [self moveButtonBack:bManager.button];
                bManager.isClosest = NO;
            }
        }
        
        double angle = [self.coordinateManager getAngle:buttonManager.button.center pointEnd:self.circle.center];

        [self moveButton:buttonManager toward:angle coords:coords];
        
        for (NSInteger i = 0;i<[self.menuButtons count];i++) {
            PRButtonManager *button = self.menuButtons[i];
            CGRect buttonFrame = button.button.frame;
            CGRect frame =  [super convertRect:buttonFrame toView:self];
            if(CGRectContainsPoint(frame, coords)){
                [button highlight];
            }else{
                [button setNormal];
            }
        }
    }
    else {
        for (PRButtonManager *buttonManager in self.menuButtons) {
            [buttonManager setNormal];
            [self moveButtonBack:buttonManager.button];
        }
    }
}

-(void)retrieveHighlightedButton:(CGPoint)coords{
    for (NSInteger i = 0;i < [self.menuButtons count]; i++){
        PRButtonManager * buttonManager = self.menuButtons[i];
        CGRect frame =  [super convertRect:buttonManager.button.frame toView:self];
        if(CGRectContainsPoint(frame, coords)){
            CGRect frame =  [super convertRect:self.circle.frame toView:self.viewToReturnCoords];
            [self.delegate  buttonAtIndex:i pushedAt:frame.origin];
        }
    }
}

-(void)remove{
    [self removeFromSuperview];
    [self.circle removeFromSuperview];
    for (PRButtonManager *button in self.menuButtons) {
        [self moveButtonBack:button.button];
        [button setNormal];
        [button.button removeFromSuperview];
        [button.helpLabel removeFromSuperview];
    }
    [self.innercircle removeFromSuperview];
     self.circle = nil;
     self.innercircle = nil;
}

-(NSArray *)getPointArray{
    NSMutableArray *pointArray = [[NSMutableArray alloc]init];
    for (PRButtonManager *buttonManager in self.menuButtons) {
        CGPoint buttonPoint = buttonManager.button.center;
        [pointArray addObject:[NSValue valueWithCGPoint:buttonPoint]];
    }
    return [pointArray copy];
}

-(IBAction)buttonPushed:(UIButton *)button{
    NSLog(@"button pushed");
}

@end
