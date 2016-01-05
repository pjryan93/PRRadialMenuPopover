# PRRadialMenuPopover

[![CI Status](http://img.shields.io/travis/Patrick Ryan/PRRadialMenuPopover.svg?style=flat)](https://travis-ci.org/Patrick Ryan/PRRadialMenuPopover)
[![Version](https://img.shields.io/cocoapods/v/PRRadialMenuPopover.svg?style=flat)](http://cocoapods.org/pods/PRRadialMenuPopover)
[![License](https://img.shields.io/cocoapods/l/PRRadialMenuPopover.svg?style=flat)](http://cocoapods.org/pods/PRRadialMenuPopover)
[![Platform](https://img.shields.io/cocoapods/p/PRRadialMenuPopover.svg?style=flat)](http://cocoapods.org/pods/PRRadialMenuPopover)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

    
    
Create an array of buttons and another of strings to pass to the menu. Then Create an instance of PRPopoverButtonMenu.
    
   ```Objective-C
   self.touchContextMenu = [[PRPopoverButtonMenu alloc] initWithFrame:self.collectionView.frame
        withButtons:buttons   //array of buttons  
        helpText:helpText     //array of text to be displayed above buttons
        controller:self       //CollectionViewController using the menu, needed to translate coords
        withOffset:offset       
        labelSize:CGSizeMake(60, 20)    
        withRadius:80       
        angleScaler:2.1     
        initialThetaOffset:0];  

    self.touchContextMenu.delegate = self;
    
    [self.collectionView addGestureRecognizer:self.touchContextMenu.longPressReconizer];
   ```
   
    4)add the delegate methods to the collectionviewcontroller
    
    - (BOOL) buttonMenu:(PRPopoverButtonMenu*)buttonMenu shouldShowAtPoint:(CGPoint)point {

    }

    - (void) buttonAtIndex:(PRPopoverButtonMenu *)buttonManager didSelectButton:(NSInteger)index atPoint:(CGPoint)point {
    

    }
    
## Requirements

## Installation

PRRadialMenuPopover is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PRRadialMenuPopover"
```

## Author

Patrick Ryan, pjryan@my.okcu.edu

## License

PRRadialMenuPopover is available under the MIT license. See the LICENSE file for more info.
