//
//  PRViewController.m
//  PRRadialMenuPopover
//
//  Created by Patrick Ryan on 01/04/2016.
//  Copyright (c) 2016 Patrick Ryan. All rights reserved.
//

#import "PRCollectionViewController.h"
@interface PRCollectionViewController ()
@property PRPopoverButtonMenu *touchContextMenu;
@end

@implementation PRCollectionViewController

static NSString * const reuseIdentifier = @"cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *helpText = @[ NSLocalizedString(@"Action 1", @""), NSLocalizedString(@"Action 2", @""), NSLocalizedString(@"Delete", @"") ];
    NSArray *buttons = [self touchContextMenuButtons];
    CGFloat offset = self.navigationController.navigationBar.frame.origin.x +
    self.navigationController.navigationBar.frame.size.height;
    
   self.touchContextMenu = [[PRPopoverButtonMenu alloc] initWithFrame:self.collectionView.frame
        withButtons:buttons
        helpText:helpText
        controller:self
        withOffset:offset
        labelSize:CGSizeMake(60, 20)
        withRadius:80
        angleScaler:2.1
        initialThetaOffset:0];
    
    self.touchContextMenu.delegate = self;
    [self.collectionView addGestureRecognizer:self.touchContextMenu.longPressReconizer];

	// Do any additional setup after loading the view, typically from a nib.
}

- (NSArray *) touchContextMenuButtons {
    CGRect frame = CGRectMake(0, 0, 44, 44);
    
    UIButton *buttonView = [[UIButton alloc]initWithFrame:frame];
    
    [buttonView setImage:[UIImage imageNamed:@"Image-3"] forState:UIControlStateNormal];
    [buttonView setImage:[UIImage imageNamed:@"Image-2"] forState:UIControlStateHighlighted];
    
    UIButton *buttonView2 = [[UIButton alloc]initWithFrame:frame];
    
    [buttonView2 setImage:[UIImage imageNamed:@"Image-3"] forState:UIControlStateNormal];
    [buttonView2 setImage:[UIImage imageNamed:@"Image-2"] forState:UIControlStateHighlighted];
    
    
    UIButton *buttonView3 = [[UIButton alloc]initWithFrame:frame];
    
    [buttonView3 setImage:[UIImage imageNamed:@"Image-1"] forState:UIControlStateNormal];
    [buttonView3 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateHighlighted];
    
    buttonView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    buttonView.layer.shadowOffset = CGSizeMake(0, 0);
    buttonView.layer.shadowRadius = 2.0;
    buttonView.layer.shadowOpacity = 0.4;
    
    buttonView2.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    buttonView2.layer.shadowOffset = CGSizeMake(0, 0);
    buttonView2.layer.shadowRadius = 2.0;
    buttonView2.layer.shadowOpacity = 0.4;
    
    buttonView3.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    buttonView3.layer.shadowOffset = CGSizeMake(0, 0);
    buttonView3.layer.shadowRadius = 2.0;
    buttonView3.layer.shadowOpacity = 0.4;

    return @[buttonView, buttonView2, buttonView3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    // Configure the cell
    return cell;
}

#pragma mark - Touch Context Delegate

- (BOOL) buttonMenu:(PRPopoverButtonMenu*)buttonMenu shouldShowAtPoint:(CGPoint)point {
    return ( [self.collectionView cellForItemAtIndexPath:[self.collectionView indexPathForItemAtPoint:point]] != nil );
}

- (void) buttonAtIndex:(PRPopoverButtonMenu *)buttonManager didSelectButton:(NSInteger)index atPoint:(CGPoint)point {
    static NSInteger kScheduleIndex = 0;
    static NSInteger kDeleteIndex = 1;
    
    NSIndexPath *cellPath = [self.collectionView indexPathForItemAtPoint:point];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:cellPath];
    
    if ( !cell ) {
        return;
    }
    
    
    if ( index == kScheduleIndex ) {
        NSLog(@"Action 1");
    } else if ( index == kDeleteIndex ) {
        NSLog(@"Action 2");
    }else{
        NSLog(@"Delete");
    }
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
