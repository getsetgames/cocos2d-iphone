//
//  SWFTest.m
//  GSGGameSWF
//
//  Created by dario on 13-02-13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SWFTest.h"
#import "mygameswf.h"

@implementation SWFTest

-(void) draw
{
    before_draw();
    advance_gameswf_c();
    after_draw();
}

@end
