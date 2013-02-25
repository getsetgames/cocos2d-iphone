//
//  CCSWFNode.m
//  GSGGameSWF
//
//  Created by dario on 13-02-25.
//
//

#import "CCSWFNode.h"
#import "CCGameSWF.h"
#import "cocos2d.h"
#import "gameswf.h"
#import "gameswf_player.h"
#import "gameswf_root.h"
#import "ccMacros.h"
#import "gameswf_types.h"
#import "gameswf_impl.h"

@interface CCSWFNode_imp : NSObject
{
    @public
    gameswf::gc_ptr<gameswf::player> m_player;
    gameswf::gc_ptr<gameswf::root>	m_movie;
}

-(id) initWithSWFFile:(NSString*)file;

@end

@implementation CCSWFNode_imp

-(id) initWithSWFFile:(NSString *)file
{
    self = [super init];
    if (self)
    {
        // make sure CCGameSWF is initialized //
        [CCGameSWF sharedInstance];
        m_player = new gameswf::player();
        m_movie = m_player->load_file([file UTF8String]);
        if (m_movie == NULL)
        {
            printf("ERROR: Cannot open input file %s", [file UTF8String]);
            [self release];
            return nil;
        }
    }
	
	return self;
}

-(void) dealloc
{
    delete m_movie;
    delete m_player;
    [super dealloc];
}

@end



@implementation CCSWFNode

+(id) nodeWithSWFFile:(NSString*)file
{
    return [[[CCSWFNode alloc] initWithSWFFile:file] autorelease];
}

-(id) initWithSWFFile:(NSString*)file
{
    self = [super init];
    if (self)
    {
        imp = [[CCSWFNode_imp alloc] initWithSWFFile:file];
        if (!imp)
        {
            [self release];
            return nil;
        }
        m_movieWidth = imp->m_movie->m_def->m_frame_size.m_x_max - imp->m_movie->m_def->m_frame_size.m_x_min;
        m_movieHeight = imp->m_movie->m_def->m_frame_size.m_y_max - imp->m_movie->m_def->m_frame_size.m_y_min;
        m_movieName = [[NSString alloc] initWithUTF8String:imp->m_movie->m_movie->m_name.c_str()];
        m_localScaleX = (imp->m_movie->get_movie_width() / m_movieWidth);
        m_localScaleY = -(imp->m_movie->get_movie_height() / m_movieHeight);
        m_scaleX = 1.0;
        m_scaleY = 1.0;
        
        [self setContentSizeInPixels:CGSizeMake(m_movieWidth, m_movieHeight)];
        [self setScale:1.0];
        [self setAnchorPoint:ccp(0.5f, 0.5f)];
    }
    return self;
}

-(float) scale
{
    NSAssert( m_scaleX == m_scaleY, @"CCNode#scale. ScaleX != ScaleY. Don't know which one to return");
	return m_scaleX;
}

-(void) setScale:(float)scale
{
    m_scaleX = m_scaleY = scale;
    [super setScaleX:m_localScaleX * m_scaleX];
    [super setScaleY:m_localScaleY * m_scaleY];
}

-(float) scaleX
{
    return m_scaleX;
}

-(void) setScaleX:(float)scaleX
{
    m_scaleX = scaleX;
    [super setScaleX:m_localScaleX * m_scaleX];
}

-(float) scaleY
{
    return m_scaleY;
}

-(void) setScaleY:(float)scaleY
{
    m_scaleY = scaleY;
    [super setScaleY:m_localScaleY];
}

-(void) dealloc
{
    [m_movieName release];
    [super dealloc];
}

-(void) onEnterTransitionDidFinish
{
    [self scheduleUpdate];
}

-(void) onExit
{
    [self unscheduleAllSelectors];
}

-(void) update:(ccTime)dt
{
    imp->m_movie->advance(dt);
    // TODO: Enable sound //
    // sound->advance(delta_t);
}

-(void) draw
{	
	/*if (s_mouse_event.size() > 0)
	{
        //	printf("notify= %d %d %d %d\n", s_mouse_event.size(), s_mouse_event[0].m_x, s_mouse_event[0].m_y, s_mouse_event[0].m_state);
		m->notify_mouse_state(s_mouse_event[0].m_x, s_mouse_event[0].m_y, s_mouse_event[0].m_state);
		s_mouse_event.remove(0);
	}*/
    
    CC_DISABLE_DEFAULT_GL_STATES();
    
    glEnable(GL_BLEND);
    
    glDisable(GL_TEXTURE_2D);
    
	imp->m_movie->display();
    
    CC_ENABLE_DEFAULT_GL_STATES();
}

@end
