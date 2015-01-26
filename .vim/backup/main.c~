#include <GL/freeglut.h>
#include "managers/game.h"
#include "models/string_util.h"


// Prototype declaration **************************************************
void init_window(void);   // ウィンドウの初期化


// Main **************************************************
int main(int argc, char *argv[])
{
  char app_title[64];
#ifdef _WIN32
  convert_char_code("SHIFT-JIS", "UTF-8", APP_TITLE, app_title, sizeof(app_title));
#else
  strcpy(app_title, APP_TITLE);
#endif
  glutInit(&argc, argv);
  init_window();
  glutCreateWindow(app_title);
  play_game();
  return 0;
}

/**
 * ウィンドウの初期化
 */
void init_window()
{
  glutInitDisplayMode(GLUT_RGBA);
  glutInitWindowPosition(WINDOW_POS_X, WINDOW_POS_Y);
  glutInitWindowSize(WINDOW_WIDTH, WINDOW_HEIGHT);
}
