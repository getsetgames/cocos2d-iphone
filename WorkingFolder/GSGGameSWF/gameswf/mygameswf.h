#ifndef MYGAMESWF_H
#define MYGAMESWF_H

#ifdef __cplusplus
extern "C"
{
#endif
    void before_draw();
    void after_draw();
    void advance_gameswf_c();
#ifdef __cplusplus
}
#endif

void advance_gameswf();
bool init_gameswf(int argc, char *argv[]);
void set_gameswf_window(int backingWidth, int backingHeight);

void onMouseDown(float x, float y);
void onMouseUp(float x, float y);
void onMouseMove(float x, float y);

struct mouse_event
{
	int m_x;
	int m_y;
	int m_state;
};

#endif