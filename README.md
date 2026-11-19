# MyanmarKey — မြန်မာ (Unicode) Input Method for macOS

KeyMagic လို English ↔ မြန်မာ ပြောင်းရိုက်လို့ရတဲ့ app။ MacBook အတွက်
Swift + Input Method Kit (IMK) နဲ့ အသစ်ကနေ ရေးထားတာ။

> ⚠️ **သတိထားရန် — ဒီ version က စမ်းသပ် မပြီးသေးဘူး။**
> ကျွန်တော် (Muse) မှာ Mac မရှိလို့ ဒီ code ကို build လုပ်ပြီး
> စမ်းသုံးတာ မရှိသေးဘူး။ MacBook မှာ Xcode နဲ့ build လုပ်ပြီး
> စမ်းကြည့်မှ အမှန်ကို သိရမယ်။ ပြဿနာ တွေ့ရင် screenshot + error စာသား
> ပို့ပေးပါ — ပြင်ပေးမယ်။

---

## ၁။ ဒီ app က ဘာလဲ

- မြန်မာ Unicode စာကို QWERTY keyboard နဲ့ ရိုက်လို့ရတဲ့ input method။
- Layout တစ်ခု — Myanmar3 / Pyidaungsu-MM ပုံစံ
  (Microsoft Windows ရဲ့ Myanmar Unicode layout ကို အခြေခံထားတယ်)။
- English / မြန်မာ ပြောင်းဖို့ နည်း ၂ မျိုး —
  **Control + Option + M (⌃⌥M)** နှိပ်တာ၊ ဒါမှမဟုတ် menu bar က
  မြ / EN ကို နှိပ်ပြီး ရွေးတာ။
- Menu bar မှာ လက်ရှိ မုဒ် ပြတယ် — မြ = မြန်မာ၊ EN = English။
- Dock မှာ icon မပေါ်ဘူး (menu bar app)။

## ၂။ လိုအပ်ချက်များ

- MacBook (macOS 13 Ventura သို့မဟုတ် အထက်)။
- **Xcode** — App Store ကနေ အခမဲ့ ဒေါင်းလုဒ်ဆွဲလို့ရတယ်။
  (ဖိုင် အရမ်းကြီးတယ် — အင်တာနက် ကောင်းတဲ့ အချိန် ဒေါင်းလုဒ်ဆွဲပါ။)
- **Apple ID** (အခမဲ့ ရတဲ့ အကောင့် ရတယ် — ပိုက်ဆံ ပေးရတဲ့
  Developer အကောင့် မလိုဘူး)။ app ကို sign လုပ်ဖို့ လိုတယ်။

## ၃။ Xcode မှာ ဖွင့်နည်း

1. `MyanmarKey.xcodeproj` ဖိုင်ကို double-click နှိပ်ပြီး ဖွင့်ပါ။
   (Xcode ပွင့်လာမယ်။)
2. ပထမဆုံး ဖွင့်တဲ့အခါ Xcode က "Trust this project?" လို့ မေးနိုင်တယ် —
   **Trust** ကို နှိပ်ပါ။

## ၄။ Signing လုပ်နည်း (ပထမဆုံး တစ်ခါပဲ လုပ်ရမယ်)

Build လုပ်ဖို့ ကိုယ့် Apple ID နဲ့ sign လုပ်ရမယ်။

1. Xcode ဖွင့်ထားတဲ့အခါ — Xcode menu > **Settings…** > **Accounts** >
   **+** နှိပ်ပြီး ကိုယ့် Apple ID နဲ့ sign in လုပ်ပါ။
   (Apple ID မရှိရင် အခမဲ့ ဖွင့်လို့ရတယ်။)
2. Xcode ရဲ့ ဘယ်ဘက် အပေါ်မှာ **MyanmarKey** project ကို နှိပ်ပါ။
3. အလယ်မှာ **MyanmarKey** target ကို ရွေးပြီး **Signing & Capabilities**
   tab ကို နှိပ်ပါ။
4. **Team** ဘေးက dropdown မှာ ကိုယ့် နာမည် (Personal Team) ကို ရွေးပါ။
5. "Automatically manage signing" ကို အမှန် ခြစ်ထားပါ။

## ၅။ Build + Run လုပ်နည်း

1. Xcode အပေါ်က **▶ Run** ခလုတ် (ဒါမှမဟုတ် **Cmd+R**) ကို နှိပ်ပါ။
2. ပထမဆုံး Run တဲ့အခါ macOS က permission တောင်းနိုင်တယ် —
   **System Settings > Privacy & Security > Input Monitoring** ထဲမှာ
   MyanmarKey ကို ခွင့်ပြုပေးပါ။ (တောင်းမှ ပေးပါ။)
3. Run ဖြစ်သွားရင် menu bar အပေါ်မှာ **မြ** လို့ ပေါ်လာမယ်။
   အဲဒါ app အလုပ် လုပ်နေပြီ ဆိုတဲ့ သင်္ကေတပဲ။
4. Build ပဲ လုပ်ချင်ရင် **Cmd+B** နှိပ်ပါ။

## ၆။ Install လုပ်နည်း (input method အနေနဲ့ သုံးဖို့)

Xcode ကနေ Run တာနဲ့ input method အနေနဲ့ သုံးလို့ မရသေးဘူး။
Built .app ကို Input Methods ဖိုဒါထဲ ကူးထည့်ရမယ်။

1. Xcode မှာ **Product > Build** (Cmd+B) လုပ်ပါ။
2. ဘယ်ဘက် Products အောက်က **MyanmarKey.app** ကို
   right-click > **Show in Finder** နှိပ်ပါ။
3. `MyanmarKey.app` ကို ကူးပြီး အောက်က ဖိုဒါထဲ ထည့်ပါ —
   `~/Library/Input Methods/`
   (Finder မှာ **Go > Go to Folder…** ကို နှိပ်ပြီး
   `~/Library/Input Methods` လို့ ရိုက်ထည့်ပါ။ ဖိုဒါ မရှိရင်
   အသစ် ဆောက်ပါ။)
4. ပြီးရင် Mac ကနေ **Log Out လုပ်ပြီး ပြန် Log In** လုပ်ပါ
   (ဒါမှမဟုတ် restart လုပ်ပါ)။ ဒါမှ macOS က app အသစ်ကို သိမယ်။

## ၇။ Enable လုပ်နည်း

1. **System Settings > Keyboard > Input Sources** ကို သွားပါ။
2. **+** နှိပ်ပြီး **Burmese** (ဒါမှမဟုတ် English / Others) အောက်က
   **MyanmarKey** ကို ရှာပြီး **Add** နှိပ်ပါ။
   (ဘယ် အမျိုးအစားအောက်မှာ ပေါ်မလဲ မသေချာဘူး — Burmese အောက်မှာ
   မတွေ့ရင် English ဒါမှမဟုတ် Others အောက်မှာ ရှာကြည့်ပါ။)
3. ပြီးရင် menu bar က input source icon ကနေ **MyanmarKey** ကို ရွေးပါ။
   (ဒါမှမဟုတ် Control+Space နဲ့ ပြောင်းပါ — ဒါက macOS ရဲ့
   input source ပြောင်းတဲ့ ခလုတ်ပါ။)

## ၈။ သုံးနည်း

- **မြန်မာ/English ပြောင်းဖို့** — **Control + Option + M (⌃⌥M)**
  နှိပ်ပါ။ ဒါမှမဟုတ် menu bar က **မြ / EN** ကို နှိပ်ပြီး ရွေးပါ။
- **မြန်မာ မုဒ်** — ခလုတ် နှိပ်တိုင်း မြန်မာ စာလုံး ထွက်မယ်။
  ရိုက်နေတဲ့ စာအောက်မှာ မျဉ်းတို ပေါ်နေမယ် — Space / Enter /
  မြှား နှိပ်တဲ့အခါ စာက အတည်ဖြစ်သွားမယ်။
- **English မုဒ်** — ခလုတ် အားလုံး အတိုင်း ရိုက်လို့ရမယ်။
- **Backspace** — ရိုက်နေတဲ့ စာထဲက နောက်ဆုံး တစ်လုံး ဖျက်မယ်။
  ရိုက်နေတဲ့ စာ မရှိရင် ပုံမှန်အတိုင်း ဖျက်မယ်။
- **Escape** — ရိုက်နေတဲ့ စာကို ပယ်ဖျက်မယ် (ဘာမှ မကျန်ဘူး)။

## ၉။ ရိုက်နည်း (အရေးကြီး)

**Logical order** နဲ့ ရိုက်ရမယ် — ဗျည်း အရင်၊ သရ နောက်မှ။

- "မေ" လို့ ရိုက်ချင်ရင် — **R** (မ) အရင်၊ ပြီးမှ **A** (ေ)။
- "ကျ" လို့ ရိုက်ချင်ရင် — **U** (က), **S** (ျ)။
  (ူ ကို ထည့်ရင် "ကျူ" ဖြစ်သွားမယ်။)
- "မင်္ဂလာပါ" လို့ ရိုက်ချင်ရင် —
  **R**(မ) **I**(င) **F**(် အသတ်) **Shift+F**(် ဗီရာမ) **Shift+;**(ဂ)
  **V**(လ) **M**(ာ) **Y**(ပ) **G**(ါ)။
  (ဂ က င အောက်မှာ ဆင့်ဖို့ Shift+F ဗီရာမ လိုတယ်။
  ပ + ါ က tall AA (G) နဲ့ ရိုက်ရမယ်။)

Zawgyi လို ေ ကို အရင် ရိုက်ပြီး ဗျည်း ထည့်တဲ့ ပုံစံ ဒီ version မှာ
မရသေးဘူး။ (v2 မှာ ထည့်ဖို့ စဉ်းစားထားတယ်။)

ခလုတ် ဇယား အပြည့်အစုံကို `MyanmarKey/KeyboardLayout.swift` ထဲမှာ
ကြည့်လို့ရတယ်။

## ၁၀။ Key mapping ပြင်နည်း

မှားတဲ့ ခလုတ် ရှိရင် `MyanmarKey/KeyboardLayout.swift` ဖိုင်ထဲမှာ
တစ်ကြောင်းတည်း ပြင်လိုက်ရုံပဲ။

ဥပမာ — Q ခလုတ်က ဆ အစား စ ထွက်စေချင်ရင် —

```swift
12: ("ဆ", "ဈ"),   // Q
```

ကို ဒီလို ပြင်ပါ —

```swift
12: ("စ", "ဈ"),   // Q
```

ပြီးရင် Xcode မှာ Cmd+B နှိပ်ပြီး အဆင့် ၆ အတိုင်း
`.app` ကို ပြန်ကူးထည့်ပါ။

**သတိထားရန်** — F ခလုတ်ရဲ့ စာကြောင်းကိုပဲ `\u{...}` နဲ့ ရေးထားတယ်။
အကြောင်းက plain (U+103A အသတ်) နဲ့ shifted (U+1039 ဗီရာမ)
နှစ်ခုလုံး ပုံစံ တူလို့ မှားမပြင်မိအောင်ပါ။ F ကို ပြင်ရင် codepoint
နံပါတ်ကို သေချာ ကြည့်ပါ။

## ၁၁။ App နာမည် ပြောင်းနည်း

1. Xcode မှာ project ကို ရွေးပြီး target နာမည် **MyanmarKey** ကို
   နှိပ်ပြီး နာမည် အသစ် ရိုက်ပါ။ (Xcode က rename လုပ်ပေးမလား မေးရင်
   Rename ကို နှိပ်ပါ။)
2. **Signing & Capabilities** အောက်က **Bundle Identifier** ကို
   ပြင်ပါ။ ⚠️ **bundle ID ထဲမှာ `.inputmethod.` ပါရမယ်** —
   ဥပမာ `com.sai.inputmethod.နာမည်အသစ်`။
   `.inputmethod.` မပါရင် macOS က input method အနေနဲ့ မသိဘူး။
3. `Info.plist` ထဲက `CFBundleDisplayName` (MyanmarKey) ကိုလည်း
   နာမည် အသစ် ပြောင်းပါ။
4. `AppDelegate.swift` ထဲက About စာသားက "MyanmarKey" နာမည်ကို
   ပြင်ချင်ရင် ပြင်ပါ။ (မပြင်လည်း အလုပ်လုပ်တယ်။)

## ၁၂။ ဒီ MVP ရဲ့ ကန့်သတ်ချက်များ (သိထားရန်)

- **Unicode ပဲ ရတယ်။** Zawgyi မရသေးဘူး (နောက်မှ ထည့်မယ်)။
- **Layout တစ်ခု ပဲ ရှိတယ်** (Myanmar3 / Pyidaungsu-MM ပုံစံ)။
- **Logical order ပဲ ရတယ်** (ဗျည်း အရင်၊ သရ နောက်မှ)။
  Zawgyi လို visual order ပြန်စီပေးတာ မပါဘူး။
- **Settings UI မရှိသေးဘူး** (hotkey / layout ပြင်ချင်ရင် code ထဲမှာ ပြင်ရမယ်)။
- **Icon မရှိသေးဘူး** — Input Sources စာရင်းမှာ ပုံမှန် icon ပဲ ပေါ်မယ်။
- **Caps Lock ကို လျစ်လျူရှုထားတယ်** — Shift layer ကို Shift နဲ့ပဲ ရွေးတယ်။
- **Sandbox မပါဘူး** — App Store တင်ဖို့ လိုမှ sandbox + entitlements
  ထည့်ရမယ်။ ကိုယ့်ဘာသာ သုံးဖို့ မလိုဘူး။
- **မစမ်းရသေးဘူး** — Mac မှာ ပထမဆုံး build လုပ်တဲ့အခါ error ရှိနိုင်တယ်။

## ၁၃။ ပြဿနာ ဖြေရှင်းနည်း

- **Build error တက်ရင်** — error စာသား အတိုင်း screenshot ရိုက်ပြီး
  ပို့ပေးပါ။ အများစုက signing ပြဿနာ (အဆင့် ၄ ကို ပြန်စစ်ပါ)။
- **Input Sources ထဲမှာ MyanmarKey မပေါ်ရင်** —
  `.app` က `~/Library/Input Methods/` ထဲမှာ ဟုတ်လား စစ်ပါ။
  ပြီးရင် Log Out / Log In ပြန်လုပ်ပါ။
- **"Connection failed" လို့ ပေါ်ရင်** — Activity Monitor မှာ
  MyanmarKey ကို ရှာပြီး Quit လုပ်ပါ။ ပြီးရင် Input Sources ကနေ
  MyanmarKey ကို ပြန်ရွေးပါ။
- **စာ ရိုက်မရရင်** — Console.app ဖွင့်ပြီး "MyanmarKey" လို့ ရှာပါ။
  Log ထဲက စာသားကို ပို့ပေးပါ။
- **Menu bar မှာ မြ / EN မပေါ်ရင်** — app က run နေလား စစ်ပါ
  (Activity Monitor မှာ MyanmarKey ရှာပါ)။

## ၁၄။ ဖိုင် ဖွဲ့စည်းပုံ

```
MyanmarKey.xcodeproj/     Xcode project (ဒါကို double-click ဖွင့်ပါ)
MyanmarKey/
  AppDelegate.swift       app စတင်ခြင်း + IMKServer + menu bar
  InputController.swift   ခလုတ် နှိပ်တိုင်း ကိုင်တွယ်ခြင်း (အဓိက)
  KeyboardLayout.swift    ခလုတ် → မြန်မာ စာလုံး ဇယား (ပြင်ဖို့ ဒီဖိုင်)
  AppState.swift          မြန်မာ/English မုဒ် + ပြောင်းတဲ့ ခလုတ် သတ်မှတ်ချက်
  Info.plist              macOS ကို input method လို့ ပြောတဲ့ စာရင်း
README.md                 ဒီ ဖိုင်
```

## ၁၅။ ရင်းမြစ် (References)

- Apple NumberInput_IMKit_Sample (InputMethodKit နမူနာ)
- ensan-hcl/macOS_IMKitSample_2021 (Swift IMK နမူနာ — AppDelegate ပုံစံ)
- Shiki Suen, "macOS Input Method Development Guidelines for 2026"
  (InputMethodConnectionName = bundle ID + "_Connection" စည်းမျဉ်း)
- Microsoft Myanmar keyboard layout, KBDMYAN (kbdlayout.info) —
  key mapping ဇယား ရင်းမြစ်
- Waseda University, Myanmar3 keyboard layout စာတမ်း —
  QWERTY တန်း တိုက်ဆိုင် စစ်ဆေးချက်
