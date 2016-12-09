/*
 * Copyright (C) 2009 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <linux/input.h>
#include <unistd.h>

#include "common.h"
#include "device.h"
#include "screen_ui.h"
#include <cutils/properties.h>

class BcmRecoveryUI : public ScreenRecoveryUI {
  public:
    virtual KeyAction CheckKey(int key, bool is_long_press) {

        if (key == KEY_HOME) {
            return TOGGLE;
        }

        return RecoveryUI::CheckKey(key, is_long_press);
    }

    void Init() override {
        ScreenRecoveryUI::Init();
    }
};

Device* make_device() {
   char value[PROPERTY_VALUE_MAX];

   for (;;) {
      memset(value, 0, sizeof(value));
      property_get("dyn.nx.state", value, NULL);
      if (strlen(value) && !strncmp(value, "loaded", strlen(value))) {
         break;
      }
      sleep(1);
   }

   return new Device(new BcmRecoveryUI);
}
