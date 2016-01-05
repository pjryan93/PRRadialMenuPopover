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
@property NSInteger cellNumber;
@end

@implementation PRCollectionViewController

static NSString * const reuseIdentifier = @"cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    //number of cells in collectionView
    self.cellNumber = 10;
    
    //Text Displayed above buttons
    NSArray *helpText = @[ NSLocalizedString(@"Action 1", @""), NSLocalizedString(@"Action 2", @""), NSLocalizedString(@"Action 3", @""), NSLocalizedString(@"Delete", @"") ];
    //Array of UIButtons to be displayed.
    NSArray *buttons = [self touchContextMenuButtons];
    CGFloat offset = 0;
    
    //create the menu
   self.touchContextMenu = [[PRPopoverButtonMenu alloc] initWithFrame:self.collectionView.frame
        withButtons:buttons     //array of buttons
        helpText:helpText       //array of help label text
        controller:self         // the controller collectionviewController
        withOffset:offset       //offset between nav bar
        labelSize:CGSizeMake(60, 20)    //help label size
        withRadius:80        //radius from center of gesture to button
        angleScaler:2.1     // a scalar the alters the distance between the buttons.
        initialThetaOffset:0];  //initial offset of the arc the buttons are laid out on
    
    //set the delegate
    self.touchContextMenu.delegate = self;
    
    //add the reconizer
    [self.collectionView addGestureRecognizer:self.touchContextMenu.longPressReconizer];

	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Touch Context Delegate

- (BOOL) buttonMenu:(PRPopoverButtonMenu*)buttonMenu shouldShowAtPoint:(CGPoint)point {
    return ( [self.collectionView cellForItemAtIndexPath:[self.collectionView indexPathForItemAtPoint:point]] != nil );
}

- (void) buttonAtIndex:(PRPopoverButtonMenu *)buttonManager didSelectButton:(NSInteger)index atPoint:(CGPoint)point {
    
    NSIndexPath *cellPath = [self.collectionView indexPathForItemAtPoint:point];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:cellPath];
    
    if ( !cell ) {
        return;
    }
    
    
    if ( index == 0 ) {
        NSLog(@"Action 1");
    } else if ( index == 1 ) {
        NSLog(@"Action 2");
    }else if(index == 2){
        NSLog(@"Action 3");
    }else {
        NSLog(@"Delete");
        self.cellNumber--;
        [self.collectionView deleteItemsAtIndexPaths:@[cellPath]];
    }
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
    
    [buttonView3 setImage:[UIImage imageNamed:@"Image-3"] forState:UIControlStateNormal];
    [buttonView3 setImage:[UIImage imageNamed:@"Image-2"] forState:UIControlStateHighlighted];
    
    UIButton *buttonView4 = [[UIButton alloc]initWithFrame:frame];
    
    [buttonView4 setImage:[UIImage imageNamed:@"Image-1"] forState:UIControlStateNormal];
    [buttonView4 setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateHighlighted];
    
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
    
    buttonView4.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    buttonView4.layer.shadowOffset = CGSizeMake(0, 0);
    buttonView4.layer.shadowRadius = 2.0;
    buttonView4.layer.shadowOpacity = 0.4;

    return @[buttonView, buttonView2, buttonView3,buttonView4];
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
    return self.cellNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    // Configure the cell
    return cell;
}




@end
