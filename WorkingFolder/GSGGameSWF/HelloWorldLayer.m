//
//  HelloWorldLayer.m
//  GSGGameSWF
//
//  Created by dario on 13-02-13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCSWFNode.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
        
        CCNode *swf = [CCSWFNode nodeWithSWFFile:[[NSBundle mainBundle] pathForResource:@"menu001" ofType:@"swf"]];
        [self addChild:swf];
        swf.position = ccp( size.width /2 , size.height/2 );
        
        // add the label as a child to this Layer
		[self addChild: label];
        
        m_label = label;
	}
	return self;
}

-(void) onEnter
{
    [self scheduleUpdate];
    [super onEnter];
}

-(void) update:(ccTime)dt
{
    m_label.rotation += 1.0f;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
