# PRRadialMenuPopover

[![Version](https://img.shields.io/cocoapods/v/PRRadialMenuPopover.svg?style=flat)](http://cocoapods.org/pods/PRRadialMenuPopover)
[![License](https://img.shields.io/cocoapods/l/PRRadialMenuPopover.svg?style=flat)](http://cocoapods.org/pods/PRRadialMenuPopover)
[![Platform](https://img.shields.io/cocoapods/p/PRRadialMenuPopover.svg?style=flat)](http://cocoapods.org/pods/PRRadialMenuPopover)

<img src="https://cloud.githubusercontent.com/assets/7769635/12105902/236203e0-b31f-11e5-902a-659ae0364843.gif" width="30%"></img> 

PRRadialMenu is a menu of buttons that extends from a point in a collection view.  The menu is shown after a long press.  The menu adjusts spacing based off the number of buttons.  More updates coming soon.   

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Create an array of buttons to pass to the PopOverMenu.  The menu will adjust to the number of buttons in the array.  You must set an image for the highlated and normal state of the buttons.  Below is an easy way to make circular buttons.
   ```Objective-C
   
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
   NSArray *buttonArray = @[buttonView, buttonView2, buttonView3, buttonView4];
   ```
   Next create the PRPopoverButtonMenu, assign the delegate, and add the gesture reconizer.
   
   ```Objective-C
   self.touchContextMenu = [[PRPopoverButtonMenu alloc] initWithFrame:self.collectionView.frame
        withButtons:buttons   //array of buttons  
        helpText:helpText     //array of text to be displayed above buttons
        controller:self       //CollectionViewController using the menu, needed to translate coords
        withOffset:offset     //offset betweeen navbar and top of view.  Used to detect if buttons will animate under nav bar
        labelSize:CGSizeMake(60, 20)  //size of labels above butons  
        withRadius:80       //radius from long press gesture to center of button
        angleScaler:2.1     //a scaler that adjusts the angle between the buttons
        initialThetaOffset:0]; //the initial offset of the arc where the buttons are placed.

    //set the delegate method
    self.touchContextMenu.delegate = self;
    
    //add the gesture reconizer to the collection view
    [self.collectionView addGestureRecognizer:self.touchContextMenu.longPressReconizer];
   ```
    Add the two delegate methods to the collectionviewcontroller
    
    Used this method to show the menu.  Make sure there is a valid cell on the point pushed.
    shouldShowAtPoint:(CGPoint)point 
    
    Used this method get the index of a pushed button. The Point returned is the point of the gesture.
    didSelectButton:(NSInteger)index atPoint:(CGPoint)point 
    
   ```Objective-C
     //Use this method to gurantee the location of the push was over a valid cell.
    - (BOOL) buttonMenu:(PRPopoverButtonMenu*)buttonMenu shouldShowAtPoint:(CGPoint)point {
            return ( [self.collectionView cellForItemAtIndexPath:[self.collectionView indexPathForItemAtPoint:point]] != nil );
    }
    
    //This method is called when the button a button has been pushed.
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
   ```
    
    
## Requirements

## Installation

PRRadialMenuPopover is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PRRadialMenuPopover"
```

## Author

Patrick Ryan, patrick@patrickjryan.net

## License

PRRadialMenuPopover is available under the MIT license. See the LICENSE file for more info.
