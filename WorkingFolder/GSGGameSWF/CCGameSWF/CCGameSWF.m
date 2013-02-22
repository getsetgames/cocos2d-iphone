//
//  CCGameSWF.m
//  CCGameSWF
//
//  Created by dario on 13-02-22.
//
//

#import "CCGameSWF.h"
#import "CCGameSWF_Bridge.h"

@implementation CCGameSWF

+(CCGameSWF*) sharedInstance
{
    static CCGameSWF *s_ccGameSWF_sharedInstance = nil;
    if (!s_ccGameSWF_sharedInstance)
    {
        s_ccGameSWF_sharedInstance = [[CCGameSWF alloc] init];
    }
    return s_ccGameSWF_sharedInstance;
}

-(id) init
{
    self = [super init];
    
    if (self)
    {
        m_fscommandListeners = [[NSMutableDictionary alloc] init];
        CCGameSWF_init();
    }
	
	return self;
}

-(void) dealloc
{
    [m_fscommandListeners release];
    
    [super dealloc];
}

#pragma mark - fscommand handlers
-(void) addFscommandResponder:(id<CCSWFFscommandResponder>)responder forMovieNamed:(NSString*)movieName
{
    NSMutableArray *movieResponders = [m_fscommandListeners objectForKey:movieName];
    if (!movieResponders)
    {
        movieResponders = [NSMutableArray array];
        [m_fscommandListeners setObject:movieResponders forKey:movieName];
    }
    
    [movieResponders addObject:responder];
}

-(void) removeFscommandResponder:(id<CCSWFFscommandResponder>)responder forMovieNamed:(NSString*)movieName
{
    NSMutableArray *movieResponders = [m_fscommandListeners objectForKey:movieName];
    if (!movieResponders)
    {
        NSLog(@"ERROR: trying to remove fscommand responder from empty responder list, did you pass the correct movie name?");
        return;
    }
    
    [movieResponders removeObject:responder];
    
    if ([movieResponders count] == 0)
    {
        [m_fscommandListeners removeObjectForKey:movieName];
    }
}

-(void) movieNamed:(NSString*)movieName sentCommand:(NSString*)command withArguments:(NSString*)args
{
    NSMutableArray *movieResponders = [m_fscommandListeners objectForKey:movieName];
    if (movieResponders)
    {
        for (int i = 0; i < [movieResponders count]; ++i)
        {
            id<CCSWFFscommandResponder> responder = [movieResponders objectAtIndex:i];
            if ([responder respondsToSelector:@selector(movieNamed:sentCommand:withArguments:)])
            {
                [responder movieNamed:movieName sentCommand:command withArguments:args];
            }
        }
    }
}

@end
