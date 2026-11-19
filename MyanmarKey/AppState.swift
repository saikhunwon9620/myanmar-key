import Cocoa

// MARK: - မြန်မာ / English မုဒ် (Mode)
//
// ဒီ app မှာ မုဒ် ၂ ခု ရှိတယ်။
//
//   .myanmar — ခလုတ် နှိပ်တိုင်း မြန်မာ စာလုံး ထွက်မယ်
//                (KeyboardLayout.swift ထဲက ဇယားအတိုင်း)။
//   .english — ခလုတ် အားလုံး အတိုင်း ဖြတ်သွားမယ် (ဘာမှ မပြောင်းဘူး)။
//
// မုဒ်ကို ပြောင်းတဲ့ နည်း ၂ မျိုး —
//   1. ခလုတ် — Control + Option + M (⌃⌥M) ကို နှိပ်ပါ။
//   2. Menu bar — မျက်နှာပြင် အပေါ်ဆုံး menu bar က မြ / EN ကို
//      နှိပ်ပြီး ရွေးပါ။
enum InputMode {
    case myanmar
    case english
}

// MARK: - AppState (တစ်နေရာတည်းက မုဒ် မှတ်တာ)
//
// InputController (ခလုတ် ကိုင်တဲ့ အပိုင်း) နဲ့ AppDelegate
// (menu bar အပိုင်း) နှစ်ခုလုံး ဒီ AppState တစ်ခုတည်းကို ကြည့်တယ်။
// ဒါကြောင့် မုဒ် ဘယ်နေရာက ပြောင်းပြောင်း နှစ်ခုလုံး အမြဲ တူညီတယ်။
final class AppState {

    static let shared = AppState()

    private init() {}

    // လက်ရှိ မုဒ်။ app စဖွင့်တဲ့အခါ မြန်မာက မူလ (default) ဖြစ်တယ်။
    var mode: InputMode = .myanmar {
        didSet {
            // menu bar ကို ပြန်ပြင်ဖို့ AppDelegate ကို အသိပေးမယ်။
            NotificationCenter.default.post(name: .inputModeDidChange, object: nil)
        }
    }

    func toggleMode() {
        mode = (mode == .myanmar) ? .english : .myanmar
    }

    // MARK: - မြန်မာ / English ပြောင်းတဲ့ ခလုတ် (Toggle hotkey)
    //
    // Control + Option + M (⌃⌥M)။
    //
    // ဒီ ခလုတ်ကို ရွေးတဲ့ အကြောင်းရင်း —
    //   • M = Myanmar လို့ မှတ်ရလွယ်တယ်။
    //   • macOS ရဲ့ မူလ ခလုတ်တွေနဲ့ မတိုက်ဘူး။
    //     Ctrl+Space က macOS ရဲ့ input source ပြောင်းတဲ့ ခလုတ်၊
    //     Cmd+Space က Spotlight ဖြစ်လို့ အဲဒါတွေကို မသုံးဘူး။
    //   • Caps Lock ကို မသုံးဘူး
    //     (စာလုံး အကြီး/အသေး ပြဿနာ ဖြစ်နိုင်လို့)။
    //
    // ခလုတ် ပြောင်းချင်ရင် ဒီနှစ်ကြောင်းကိုပဲ ပြင်ပါ။
    // keyCode ဟာ macOS ရဲ့ ခလုတ် နံပါတ် ဖြစ်တယ်
    // (ဥပမာ M = 46, L = 37, Space = 49)။
    static let toggleKeyCode: UInt16 = 46          // M ခလုတ်
    static let toggleModifiers: NSEvent.ModifierFlags = [.control, .option]
}

extension Notification.Name {
    /// မုဒ် ပြောင်းတိုင်း ပို့တဲ့ အချက်ပေးချက်။
    static let inputModeDidChange = Notification.Name("MyanmarKeyInputModeDidChange")
}
