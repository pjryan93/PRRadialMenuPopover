//
//  PRRadialMenuPopoverTests.m
//  PRRadialMenuPopoverTests
//
//  Created by Patrick Ryan on 01/04/2016.
//  Copyright (c) 2016 Patrick Ryan. All rights reserved.
//

// https://github.com/Specta/Specta

SpecBegin(InitialSpecs)

describe(@"these will fail", ^{

    it(@"can do maths", ^{
        expect(1).to.equal(1);
    });

    it(@"can read", ^{
        expect(@"number").to.equal(@"number");
    });
    
});

describe(@"these will pass", ^{
    
    it(@"can do maths", ^{
        expect(1).beLessThan(23);
    });
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
    
    it(@"will wait and succeed", ^{
        waitUntil(^(DoneCallback done) {
            done();
        });
    });
});

SpecEnd

