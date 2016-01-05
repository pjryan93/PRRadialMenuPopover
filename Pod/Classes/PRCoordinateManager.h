//
//  PRCoordinateManager.h
//  PopOverGesture
//
//  Created by Patrick Ryan on 11/13/15.
//  Copyright © 2015 Patrick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PRCoordinateManager : NSObject

@property double angleSpace;
@property double initialTheta;
@property CGPoint center;
@property double radius;
@property double buttonSize;
@property double scale;
@property double counter;

-(NSArray *)arcPointArrayAtCenter:(CGPoint)coords numberOfPoints:(NSInteger)n;
-(BOOL)isInsideArcFromCenter:(CGPoint)centerCoords closestButtonCoords:(CGPoint)buttonCoords pointTouched:(CGPoint)touchCoords;
-(NSInteger)closestIndexFromPoint:(CGPoint)point toPoints:(NSArray *)pointArray;
-(double)distanceFromCoordinate:(CGPoint)startingCoordinate toPoint:(CGPoint)endingCoordinate;
-(NSDictionary *)incrementAndScaleValueToTransfromCenter:(CGPoint)coords direction:(double)angle centerOfViewToTransfer:(CGPoint)coords;
-(double)getAngle:(CGPoint)pointStart pointEnd:(CGPoint)pointEnd;
@end
