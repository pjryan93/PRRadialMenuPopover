//
//  PRButton.m
//  TestGesture
//
//  Created by Patrick Ryan on 11/5/15.
//  Copyright © 2015 Patrick. All rights reserved.
//

#import "PRButtonManager.h"

@implementation PRButtonManager


-(id)initWithButton:(UIButton *)buttonInput andLabel:(UILabel *)label{
    self = [super init];
    if (self) {
        self.button = buttonInput;
        self.helpLabel = label;
        self.isSelectable = NO;
        self.isClosest = NO;
    }
    return self;
}

-(void)positionLabel{
    NSInteger y = self.button.frame.origin.y - self.button.frame.size.height/2;
    //width 60 height 20
    CGRect labelRect = CGRectMake(self.button.center.x - self.helpLabel.frame.size.width/2 , y,self.helpLabel.frame.size.width, self.helpLabel.frame.size.height);
    labelRect.origin.y = y;
    [self.helpLabel setFrame:labelRect];
}
-(void)highlight{
    self.button.highlighted = YES;
    [self.helpLabel setHidden:NO];
}
-(void)setNormal{
    self.button.highlighted = NO;
    [self.button setSelected:NO];
    [self.helpLabel setHidden:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
