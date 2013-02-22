//
//  CCGameSWF_Bridge.cpp
//  CCGameSWF
//
//  Created by dario on 13-02-22.
//
//

#import "CCGameSWF_Bridge.h"
#import "CCGameSWF.h"
#import "gameswf.h"
#import "gameswf_character.h"

// handler functions //
static void     CCGameSWF_fscommand_handler    (gameswf::character* movie, const char* command, const char* arg);  // fscommand handler //
static tu_file* CCGameSWF_fileOpener           (const char* url_or_path);                                          // file opener //
static void     CCGameSWF_log_handler          (bool error, const char* message);                                  // log handler //

void CCGameSWF_init()
{
    gameswf::register_file_opener_callback(&CCGameSWF_fileOpener);
    gameswf::register_fscommand_callback(&CCGameSWF_fscommand_handler);
#ifdef DEBUG
    gameswf::register_log_callback(&CCGameSWF_log_handler);
#endif
    
    // TODO: Enable audio //
//    sound = gameswf::create_sound_handler_openal();
//    gameswf::set_sound_handler(sound);
    gameswf::set_sound_handler(0);
    
    gameswf::render_handler*	render = gameswf::create_render_handler_ogles();
    gameswf::set_render_handler(render);
    
    gameswf::set_glyph_provider(gameswf::create_glyph_provider_tu());
}




void CCGameSWF_fscommand_handler (gameswf::character* movie, const char* command, const char* arg)
{
    [[CCGameSWF sharedInstance] movieNamed:[NSString stringWithUTF8String:movie->m_name.c_str()] sentCommand:[NSString stringWithUTF8String:command] withArguments:[NSString stringWithUTF8String:arg]];
}

tu_file* CCGameSWF_fileOpener           (const char* url_or_path)
{
    return NULL;
}

static void     CCGameSWF_log_handler          (bool error, const char* message)
{
    
}
