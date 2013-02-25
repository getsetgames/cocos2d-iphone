//
//  main.m
//  GSGGameSWF
//
//  Created by dario on 13-02-13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mygameswf.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    int retVal = -1;
    retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");
	
    [pool release];
    return retVal;
}
