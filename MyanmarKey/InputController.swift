import Cocoa
import InputMethodKit

// ============================================================================
//  InputController — ခလုတ် နှိပ်တိုင်း macOS က ခေါ်တဲ့ class
// ----------------------------------------------------------------------------
//  အလုပ်လုပ်ပုံ အကျဉ်း —
//  1. သုံးသူက ခလုတ် နှိပ်တိုင်း macOS က handle(event:client:) ကို ခေါ်တယ်။
//  2. ဒီ class က ခလုတ်ကို ကြည့်ပြီး ဆုံးဖြတ်တယ် —
//       • မြန်မာ စာလုံး ထွက်မယ့် ခလုတ်လား → composedText ထဲ ထည့်ပြီး
//         marked text အနေနဲ့ ပြမယ် (စာလုံးအောက်မှာ မျဉ်းတို ပေါ်မယ်)။
//       • Space / Enter / မြှား စတဲ့ ခလုတ်လား → ရိုက်နေတဲ့ စာကို
//         အတည်ပြုပြီး (commit) ခလုတ်ကို app ကို လွှဲပေးမယ်။
//       • Backspace လား → ရိုက်နေတဲ့ စာထဲက နောက်ဆုံး တစ်လုံး ဖျက်မယ်
//         (ရိုက်နေတဲ့ စာ မရှိရင် app ကို ဖျက်ခိုင်းမယ်)။
//       • Escape လား → ရိုက်နေတဲ့ စာကို ပယ်ဖျက်မယ် (cancel)။
//       • English မုဒ်လား → ခလုတ် အားလုံး အတိုင်း ဖြတ်သွားမယ်။
//  3. handle() က true ပြန်ရင် "ဒီ ခလုတ်ကို ငါ ကိုင်လိုက်ပြီ" လို့ ဆိုလိုတယ်
//     (macOS က ထပ်မလုပ်တော့ဘူး)။ false ပြန်ရင် "ငါ မကိုင်ဘူး၊
//     app ကို လွှဲပေးပါ" လို့ ဆိုလိုတယ်။
//
//  composedText ဆိုတာ "ရိုက်နေဆဲ၊ မအတည်ပြုရသေးတဲ့ စာ" ဖြစ်တယ် —
//  marked text လို့ ခေါ်တယ်။ Space / Enter / မြှား နှိပ်တာ၊ တခြား app ကို
//  ပြောင်းတာ၊ English မုဒ် ပြောင်းတာ စတဲ့ အချိန်မှာ အတည်ပြုပေးမယ်
//  (insertText နဲ့ စာထဲ ထည့်သွင်းမယ်)။
//
//  သတိထားရန် — IMKServer က client (app/window) တစ်ခုချင်းစီအတွက်
//  InputController အသစ် တစ်ခု ဖန်တီးပေးတယ်။ ဒါကြောင့် composedText က
//  client တစ်ခုချင်းစီအတွက် သီးခြား ဖြစ်တယ် (မှန်ကန်တဲ့ ပုံစံပဲ)။
// ============================================================================

// @objc က လိုအပ်တယ် — IMK က Objective-C framework ဖြစ်လို့
// ဒီ Swift class ကို Objective-C runtime က ရှာတွေ့ဖို့ပါ။
// (Info.plist ထဲက InputMethodServerControllerClass က
// "$(PRODUCT_MODULE_NAME).InputController" လို့ ညွှန်းထားတယ်။)
@objc(InputController)
final class InputController: IMKInputController {

    /// ရိုက်နေဆဲ၊ မအတည်ပြုရသေးတဲ့ စာ (marked text)။
    private var composedText = ""

    /// macOS ရဲ့ အထူး ခလုတ် နံပါတ်များ (ပြောင်းလို့ မရတဲ့ သတ်မှတ်ချက်များ)။
    private enum KeyCode {
        static let backspace: UInt16 = 51
        static let tab: UInt16 = 48
        static let space: UInt16 = 49
        static let `return`: UInt16 = 36
        static let escape: UInt16 = 53
        static let deleteForward: UInt16 = 117
        static let leftArrow: UInt16 = 123
        static let rightArrow: UInt16 = 124
        static let downArrow: UInt16 = 125
        static let upArrow: UInt16 = 126
        static let home: UInt16 = 115
        static let end: UInt16 = 119
        static let pageUp: UInt16 = 116
        static let pageDown: UInt16 = 121
    }

    // MARK: - ခလုတ် နှိပ်တာကို ကိုင်တွယ်ခြင်း (အဓိက လုပ်ဆောင်ချက်)

    override func handle(_ event: NSEvent, client sender: Any) -> Bool {
        // keyDown ပဲ ကိုင်မယ်။ keyUp / flagsChanged တွေကို လွှဲပေးမယ်။
        // (ခလုတ် ဖိထားရင် keyDown ထပ်ခါ ရောက်လာမယ် — အဲဒါကိုလည်း
        // ပုံမှန်အတိုင်း ကိုင်မယ်၊ စာလုံး ထပ်ခါ ထွက်မယ်။)
        guard event.type == .keyDown else { return false }

        guard let client = sender as? IMKTextInput else { return false }

        // 1) မြန်မာ/English ပြောင်းတဲ့ ခလုတ် (Ctrl+Option+M) ကို အရင် စစ်မယ်။
        //    မုဒ် ဘယ်ဟာ ဖြစ်ဖြစ် ဒီ ခလုတ် အလုပ်လုပ်ရမယ်။
        if isToggleHotKey(event) {
            commitComposition(client: client)
            AppState.shared.toggleMode()
            return true
        }

        // 2) English မုဒ်မှာ ခလုတ် အားလုံး အတိုင်း ဖြတ်သွားမယ်။
        guard AppState.shared.mode == .myanmar else { return false }

        let flags = event.modifierFlags

        // 3) Cmd / Ctrl / Option နဲ့ တွဲနှိပ်တဲ့ ခလုတ်တွေ
        //    (ဥပမာ Cmd+C, Cmd+V, Ctrl+A) ကို app ကို လွှဲပေးမယ်။
        //    အရင် ရိုက်ထားတဲ့ စာကိုတော့ အတည်ပြုပေးမယ်။
        if flags.contains(.command) || flags.contains(.control) || flags.contains(.option) {
            commitComposition(client: client)
            return false
        }

        let keyCode = event.keyCode

        // 4) အထူး ခလုတ်များ။
        switch keyCode {
        case KeyCode.backspace:
            return handleBackspace(client: client)
        case KeyCode.escape:
            return handleEscape(client: client)
        case KeyCode.space, KeyCode.return, KeyCode.tab,
             KeyCode.leftArrow, KeyCode.rightArrow, KeyCode.upArrow, KeyCode.downArrow,
             KeyCode.deleteForward, KeyCode.home, KeyCode.end,
             KeyCode.pageUp, KeyCode.pageDown:
            // စာကို အတည်ပြုပြီး ခလုတ်ကို app ကို လွှဲပေးမယ်။
            // (Space ကလည်း စာကို အတည်ပြုပြီး space တစ်လုံး ရိုက်ပေးမယ်။)
            // Mouse click နှိပ်တဲ့အခါ စာကို စာရိုက်တဲ့ စနစ်က အလိုအလို
            // အတည်ပြုပေးတယ် (နောက် deactivateServer/commitComposition ကြည့်ပါ)။
            commitComposition(client: client)
            return false
        default:
            break
        }

        // 5) မြန်မာ စာလုံး ဇယားထဲက ရှာမယ်။
        //    Caps Lock ကို လျစ်လျူရှုထားတယ် — Shift layer ကို Shift နဲ့ပဲ ရွေးတယ်။
        let shift = flags.contains(.shift)
        guard let output = KeyboardLayout.output(forKeyCode: keyCode, shift: shift) else {
            // ဇယားထဲမှာ မရှိတဲ့ ခလုတ် (ဥပမာ F1–F12) —
            // စာကို အတည်ပြုပြီး ခလုတ်ကို app ကို လွှဲပေးမယ်။
            commitComposition(client: client)
            return false
        }

        // 6) စာလုံးကို composedText ထဲ ထည့်ပြီး marked text အနေနဲ့ ပြမယ်။
        composedText += output
        updateMarkedText(client: client)
        return true
    }

    // MARK: - macOS က ခေါ်တဲ့ အချိန်များ

    override func activateServer(_ sender: Any) {
        // ဒီ input method ကို စသုံးတဲ့အခါ (app/window တစ်ခု focus ရတဲ့အခါ)။
        // လုပ်စရာ မရှိဘူး — menu bar က မုဒ်ကို အမြဲ ပြထားပြီးသား။
    }

    override func deactivateServer(_ sender: Any) {
        // တခြား input method / app ကို ပြောင်းတဲ့အခါ —
        // ရိုက်နေတဲ့ စာကို အတည်ပြုမယ် (စာ မပျောက်အောင်)။
        if let client = currentClient(from: sender) {
            commitComposition(client: client)
        } else {
            // client ရှာမတွေ့ရင် buffer ကို ရှင်းထားမယ်။
            // (စာရိုက်တဲ့ စနစ်က marked text ကို သူ့ဘာသာ အတည်ပြုပေးမယ်။)
            composedText = ""
        }
    }

    override func commitComposition(_ sender: Any) {
        // macOS က "ရိုက်နေတဲ့ စာ အတည်ပြုပါ" လို့ တောင်းတဲ့အခါ
        // (ဥပမာ focus ပျောက်တဲ့အခါ၊ စာကို ရွေးတဲ့အခါ)။
        if let client = currentClient(from: sender) {
            commitComposition(client: client)
        }
    }

    override func inputText(_ string: String, client sender: Any) -> Bool {
        // ဒီ app က handle(event:client:) နဲ့ပဲ ခလုတ် ကိုင်တယ်။
        // inputText ကို မသုံးဘူး — false ပြန်မယ်။
        return false
    }

    // MARK: - Helpers (အတွင်း လုပ်ဆောင်ချက်များ)

    /// မြန်မာ/English ပြောင်းတဲ့ ခလုတ် (Ctrl+Option+M) ဟုတ်လား စစ်မယ်။
    private func isToggleHotKey(_ event: NSEvent) -> Bool {
        let flags = event.modifierFlags
        return event.keyCode == AppState.toggleKeyCode
            && flags.contains(.control)
            && flags.contains(.option)
            && !flags.contains(.command)
    }

    /// လက်ရှိ client (စာရိုက်နေတဲ့ app/window) ကို ရှာမယ်။
    private func currentClient(from sender: Any?) -> IMKTextInput? {
        if let client = sender as? IMKTextInput {
            return client
        }
        // sender က client မဟုတ်ရင် controller ရဲ့ client() ကနေ ယူမယ်။
        return self.client() as? IMKTextInput
    }

    /// Backspace — ရိုက်နေတဲ့ စာထဲက နောက်ဆုံး codepoint တစ်လုံး ဖျက်မယ်။
    /// (ရိုက်နေတဲ့ စာ မရှိရင် false ပြန်ပြီး app ကို ဖျက်ခိုင်းမယ်။)
    private func handleBackspace(client: IMKTextInput) -> Bool {
        guard !composedText.isEmpty else {
            return false
        }
        // နောက်ဆုံး codepoint တစ်လုံး ဖျက်မယ်
        // (ခလုတ် တစ်ချက် = codepoint တစ်လုံး လို့ မှတ်ရလွယ်အောင်)။
        composedText.unicodeScalars.removeLast()
        if composedText.isEmpty {
            cancelComposition(client: client)
        } else {
            updateMarkedText(client: client)
        }
        return true
    }

    /// Escape — ရိုက်နေတဲ့ စာကို ပယ်ဖျက်မယ်။
    /// (ရိုက်နေတဲ့ စာ မရှိရင် false ပြန်ပြီး app ကို လွှဲပေးမယ်။)
    private func handleEscape(client: IMKTextInput) -> Bool {
        guard !composedText.isEmpty else { return false }
        cancelComposition(client: client)
        return true
    }

    /// composedText ကို marked text အနေနဲ့ ပြမယ်
    /// (စာလုံးအောက်မှာ မျဉ်းတို ပေါ်ပြီး၊ cursor က စာအဆုံးမှာ ရှိမယ်)။
    private func updateMarkedText(client: IMKTextInput) {
        // selectedRange ရဲ့ location က UTF-16 အလုံးရေ ဖြစ်ရမယ်
        // (Swift String.count က grapheme အရေအတွက် ဖြစ်လို့ NSString.length ကို သုံးတယ် —
        // မြန်မာ စာလုံးက base + combining mark တွေ ပေါင်းထားလို့ ကွဲနိုင်တယ်)။
        let text = composedText as NSString
        client.setMarkedText(
            text,
            selectedRange: NSRange(location: text.length, length: 0),
            replacementRange: NSRange(location: NSNotFound, length: NSNotFound)
        )
    }

    /// ရိုက်နေတဲ့ စာကို အတည်ပြုမယ် (စာထဲကို တကယ် ထည့်သွင်းမယ်)။
    private func commitComposition(client: IMKTextInput) {
        guard !composedText.isEmpty else { return }
        client.insertText(
            composedText as NSString,
            replacementRange: NSRange(location: NSNotFound, length: NSNotFound)
        )
        composedText = ""
    }

    /// ရိုက်နေတဲ့ စာကို ပယ်ဖျက်မယ် (ဘာမှ မထည့်ဘဲ marked အခြေအနေ ဖျက်မယ်)။
    private func cancelComposition(client: IMKTextInput) {
        guard !composedText.isEmpty else { return }
        // marked text ကို အလွတ်နဲ့ အစားထိုးပြီး marked အခြေအနေ ဖျက်မယ်။
        // (unmarkText() ကိုပဲ ခေါ်ရင် စာက အတည်ပြုသွားမှာမို့ အရင် အလွတ် လုပ်ရမယ်။)
        client.setMarkedText(
            "" as NSString,
            selectedRange: NSRange(location: 0, length: 0),
            replacementRange: NSRange(location: NSNotFound, length: NSNotFound)
        )
        client.unmarkText()
        composedText = ""
    }
}
