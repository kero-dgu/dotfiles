#include "keyboard.h"
#include "../models/keycode.h"


// Macros **************************************************
#define KEY_NUM   256     // キーの数


// Static global variable **************************************************
static int s_keys[KEY_NUM] = { '\0' };


/**
 * キー入力状態の更新
 * @param   key_state   キーの状態
 * @param   keycode     入力されたキー
 * @param   x           マウスの X 座標
 * @param   y           マウスの Y 座標
 */
void update_keyboard(KeyState key_state, unsigned char keycode, int x, int y)
{
  int i;
  // キーの数だけループを回して入力されたキーが有るなら, キーの入力状態を配列に格納
  for (i = 0; i < KEY_NUM; ++i) {
    if (i == keycode) {
      if ((s_keys[i] == KEY_DOWN || s_keys[i] == KEY_PRESSING) &&   // キーが押され続けている状態を検知
           key_state == KEY_DOWN)   { s_keys[i] = KEY_PRESSING; }
      else if (s_keys[i] == KEY_UP) { s_keys[i] = KEY_NORMAL;   }   // 前フレームが KEY_UP ならリセット
      else                          { s_keys[i] = key_state;    }   // 通常の KEY_DOWN
    }
    else { s_keys[i] = KEY_NORMAL; }  // 入力されていないキーはリセット
  }
}

/**
 * 毎フレーム KEY_UP の状態が残っているならリセットする
 */
void reset_key_state(void)
{
  int i;
  for (i = 0; i < KEY_NUM; ++i) {
    if (s_keys[i] == KEY_UP) { s_keys[i] = KEY_NORMAL; }
  }
}

/**
 * 指定したキーの入力状態を返す
 * @param   keycode   入力されたキー
 * @return  KeyState  キーの入力状態
 */
KeyState check_key_state(unsigned char keycode)
{
  return s_keys[keycode];
}

/**
 * 指定したフレーム数だけ待機してから, キーの入力状態を返す
 * @param   keycode     入力されたキー
 * @param   wait_frame  待機するフレーム数
 * @return  KeyState    キーの入力状態
 */
KeyState check_key_state_wait_frame(unsigned char keycode, int wait_frame)
{
  static int frame_count = 0;
  if (frame_count == wait_frame) {
    frame_count = 0;
    return s_keys[keycode];
  }
  ++frame_count;
  return KEY_NORMAL;
}
