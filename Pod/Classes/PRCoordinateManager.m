//
//  PRCoordinateManager.m
//  PopOverGesture
//
//  Created by Patrick Ryan on 11/13/15.
//  Copyright © 2015 Patrick. All rights reserved.
//

#import "PRCoordinateManager.h"

@implementation PRCoordinateManager

-(NSArray *)arcPointArrayAtCenter:(CGPoint)coords numberOfPoints:(NSInteger)n{

    double increment = M_PI_2/self.angleSpace;
    double angle = M_PI_2 + self.initialTheta;

    NSMutableArray *points = [NSMutableArray array];
        
    for (NSInteger i = 0;i<n; i++){
        NSInteger x = self.radius * cos(angle);
        NSInteger y = self.radius * sin(angle);
        [points addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        angle = angle - increment;
    }
    
    //display button in correct order
    /* if ((coords.x < self.frame.size.width/2) && coords.y > self.frame.size.height/2) {
         return [[points reverseObjectEnumerator] allObjects];
    }
    else if ((coords.x  >self.frame.size.width/2) && coords.y < self.frame.size.height/2 && coords.y > self.radius) {
         return [[points reverseObjectEnumerator] allObjects];
    }*/
    
    return [points copy];
}

-(BOOL)isInsideArcFromCenter:(CGPoint)centerCoords closestButtonCoords:(CGPoint)buttonCoords pointTouched:(CGPoint)touchCoords{
    self.scale = 1.4;
    double distanceToButton = [self distanceFromCoordinate:touchCoords toPoint:buttonCoords];
    double distanceToCenter = [self distanceFromCoordinate:touchCoords toPoint:centerCoords];
    double diffrence = fabs(distanceToButton - distanceToCenter);
    
    double totalDistance = 0;
    double scaledRadius = self.radius + (self.buttonSize*self.scale);
    
    if (diffrence < scaledRadius/4 && distanceToButton + distanceToCenter > scaledRadius) {
        totalDistance =  distanceToButton + distanceToCenter - (self.buttonSize * self.scale)/2;
    }else {
        totalDistance = distanceToButton + distanceToCenter - (self.buttonSize * self.scale);
    }
    if (totalDistance < scaledRadius && distanceToCenter > self.radius/4) {
        return YES;
    }else{
        return NO;
    }
}

-(NSInteger)closestIndexFromPoint:(CGPoint)point toPoints:(NSArray *)pointArray{

    NSInteger index = 0;
    double minDistance = INFINITY;
    for (NSInteger i = 0;i<[pointArray count];i++) {
    
        CGPoint arcPoint = [[pointArray objectAtIndex:i] CGPointValue];
        double distanceToPointArcPoint = [self distanceFromCoordinate:point toPoint:arcPoint];
        
        if(distanceToPointArcPoint < minDistance){
            minDistance = distanceToPointArcPoint;
            index = i;
        }
    }
    return index;
}
-(NSDictionary *)incrementAndScaleValueToTransfromCenter:(CGPoint)coords direction:(double)angle centerOfViewToTransfer:(CGPoint)viewCenter{

    double distanceToCenter = [self distanceFromCoordinate:self.center toPoint:coords];
    double distanceToCircle = [self distanceFromCoordinate:coords toPoint:viewCenter];
    
    double distanceRatio = self.radius/distanceToCenter;
    double scaleValue = (.3/distanceRatio) + 1;
    double distanceToMove = 17/distanceRatio;
    
    double xIncrement = (distanceToMove*cos(angle));
    double yIncrement = (distanceToMove*sin(angle));
  
    /*
        Check if touch point is past the buttons midpoint
    */
    
    if (distanceToCenter > self.radius + (self.buttonSize/2))  {
    
        double distanceBackRatio = self.radius/distanceToCircle;
        double distanceToMoveBack = 16/distanceBackRatio;
    
        distanceRatio = self.radius/(self.radius +self.scale * (self.buttonSize/2));
        distanceToMove = 15/distanceRatio;
        
        xIncrement =  (distanceToMove - distanceToMoveBack)*cos(angle);
        yIncrement =  (distanceToMove - distanceToMoveBack)*sin(angle);
        
        //max scaling size
        scaleValue = 1.3;
    }
    
    return @{@"xIncrement" : [NSNumber numberWithDouble:xIncrement], @"yIncrement" : [NSNumber numberWithDouble:yIncrement], @"scale" : [NSNumber numberWithDouble:scaleValue]};
}


-(double)distanceFromCoordinate:(CGPoint)startingCoordinate toPoint:(CGPoint)endingCoordinate {
    
    return sqrt((((endingCoordinate.x - startingCoordinate.x)*(endingCoordinate.x - startingCoordinate.x)) + ((endingCoordinate.y - startingCoordinate.y)*(endingCoordinate.y - startingCoordinate.y))));
}

-(double)getAngle:(CGPoint)pointStart pointEnd:(CGPoint)pointEnd{
    double angle = 0;
    CGPoint delta = CGPointMake(pointStart.x - pointEnd.x,pointStart.y - pointEnd.y);
    angle = angle  + atan2f(delta.y,delta.x);
    return angle;
}

@end
