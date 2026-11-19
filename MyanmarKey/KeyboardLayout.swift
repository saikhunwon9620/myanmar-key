import Foundation

// ============================================================================
//  KeyboardLayout.swift — ခလုတ် → မြန်မာ စာလုံး ဇယား
// ----------------------------------------------------------------------------
//  ⚠️  DRAFT — ဒီ ဇယားက MacBook မှာ စမ်းသပ် မပြီးသေးဘူး။
//  စမ်းသုံးပြီး မှားတဲ့ ခလုတ် ရှိရင် ဒီဖိုင်ထဲမှာ တစ်ကြောင်းတည်း
//  ပြင်လိုက်ရုံပဲ (အောက်က "ပြင်နည်း ဥပမာ" ကြည့်ပါ)။
//
//  ရင်းမြစ် (reference) —
//  Microsoft Windows ရဲ့ Myanmar (Unicode) keyboard layout
//  (kbdlayout.info/KBDMYAN, kbdmyan.dll version 10.0.29667.1000) ကို
//  အခြေခံထားတယ်။ Myanmar3 / Pyidaungsu-MM layout နဲ့ အတူတူ ဖြစ်တယ် —
//  Waseda University ရဲ့ စာတမ်း (Myanmar3 keyboard layout) က
//  QWERTY တန်း (ဆ တ န မ အ ပ) နဲ့ တိုက်ဆိုင် စစ်ဆေးပြီးသား။
//
//  ရိုက်နည်း — Logical order (ဗျည်း အရင်၊ သရ နောက်မှ)။
//  ဥပမာ "မေ" လို့ ရိုက်ချင်ရင် R (မ) ကို အရင် နှိပ်၊ ပြီးမှ A (ေ) နှိပ်ပါ။
//  Zawgyi လို ေ ကို အရင် ရိုက်ပြီး ဗျည်း ထည့်တဲ့ ပုံစံ ဒီ MVP မှာ
//  မရသေးဘူး (v2 မှာ ထည့်ဖို့ စဉ်းစားထားတယ်)။
//
//  keyCode ဆိုတာ macOS ရဲ့ ခလုတ် နံပါတ် (ခလုတ် တည်နေရာ) ဖြစ်တယ် —
//  ခလုတ်ပေါ်က အင်္ဂလိပ် စာလုံး မဟုတ်ဘူး။ ဥပမာ Q ခလုတ်ရဲ့ keyCode က 12။
//  (5 နဲ့ 6 ရဲ့ keyCode က ပြောင်းပြန် ဖြစ်နေတာ macOS ရဲ့ သတ်မှတ်ချက် —
//  5 = 23, 6 = 22 — အမှား မဟုတ်ဘူး။)
//
//  ဇယားထဲမှာ မပါတဲ့ ခလုတ်များ (အတိုင်း ဖြတ်သွားမယ်) —
//  Space, Tab, Return, မြှားခလုတ်များ (စာကို အတည်ပြုပြီး ဖြတ်သွားမယ်)၊
//  F1–F12, keypad ခလုတ်များ။ Caps Lock ကို လျစ်လျူရှုထားတယ်
//  (Shift layer ကို Shift ခလုတ်နဲ့ပဲ ရွေးတယ်)။
// ============================================================================

enum KeyboardLayout {

    /// Layout နာမည် (About မှာ ပြဖို့ / နောင် layout အပို ထည့်တဲ့အခါ သုံးဖို့)။
    static let name = "Myanmar3 (Unicode)"

    /// ခလုတ် တစ်လုံးချင်းစီရဲ့ အထွက် —
    ///   plain   = Shift မပါဘဲ နှိပ်တဲ့အခါ ထွက်တဲ့ စာလုံး
    ///   shifted = Shift နဲ့ တွဲ နှိပ်တဲ့အခါ ထွက်တဲ့ စာလုံး
    ///
    /// ပြင်နည်း ဥပမာ —
    /// Q ခလုတ်က ဆ အစား စ ထွက်စေချင်ရင် အောက်က စာကြောင်းထဲက "ဆ" ကို
    /// "စ" လို့ ပြင်လိုက်ရုံပဲ။
    ///   12: ("ဆ", "ဈ"),   // Q
    /// →
    ///   12: ("စ", "ဈ"),   // Q
    static let mappings: [UInt16: (plain: String, shifted: String)] = [

        // --- အပေါ်ဆုံး ဂဏန်း တန်း ---
        50: ("ၐ", "ဎ"),   // ` (grave) — U+1050 SHA / U+100E DDHA
        18: ("၁", "ဍ"),   // 1 — U+1041 DIGIT ONE / U+100D DDA
        19: ("၂", "ၒ"),   // 2 — U+1042 DIGIT TWO / U+1052 VOCALIC R
        20: ("၃", "ဋ"),   // 3 — U+1043 DIGIT THREE / U+100B TTA
        21: ("၄", "ၓ"),   // 4 — U+1044 DIGIT FOUR / U+1053 VOCALIC RR
        23: ("၅", "ၔ"),   // 5 — U+1045 DIGIT FIVE / U+1054 VOCALIC L
        22: ("၆", "ၕ"),   // 6 — U+1046 DIGIT SIX / U+1055 VOCALIC LL
        26: ("၇", "ရ"),   // 7 — U+1047 DIGIT SEVEN / U+101B RA
        28: ("၈", "*"),   // 8 — U+1048 DIGIT EIGHT / ASTERISK
        25: ("၉", "("),   // 9 — U+1049 DIGIT NINE / LEFT PARENTHESIS
        29: ("၀", ")"),   // 0 — U+1040 DIGIT ZERO / RIGHT PARENTHESIS
        27: ("-", "_"),   // - — HYPHEN-MINUS / LOW LINE
        24: ("=", "+"),   // = — EQUALS SIGN / PLUS SIGN

        // --- QWERTY တန်း ---
        12: ("ဆ", "ဈ"),   // Q — U+1006 CHA / U+1008 JHA
        13: ("တ", "ဝ"),   // W — U+1010 TA / U+101D WA
        14: ("န", "ဣ"),   // E — U+1014 NA / U+1023 I
        15: ("မ", "၎"),   // R — U+1019 MA / U+104E AFOREMENTIONED
        17: ("အ", "ဤ"),   // T — U+1021 A / U+1024 II
        16: ("ပ", "၌"),   // Y — U+1015 PA / U+104C LOCATIVE
        32: ("က", "ဥ"),   // U — U+1000 KA / U+1025 U
        34: ("င", "၍"),   // I — U+1004 NGA / U+104D COMPLETED
        // O — U+101E SA / U+103F GREAT SA (ၿ)။
        // ⚠️ GREAT SA ကို \u{103F} လို့ ရေးထားတယ် — ပုံစံ တူတဲ့ U+107F နဲ့
        // မှားမရိုက်မိအောင်ပါ (ပုံစံ တူပေမယ့် မတူတဲ့ စာလုံး ဖြစ်တယ်)။
        31: ("သ", "\u{103F}"),
        35: ("စ", "ဏ"),   // P — U+1005 CA / U+100F NNA
        33: ("ဟ", "ဧ"),   // [ — U+101F HA / U+1027 E
        30: ("ဩ", "ဪ"), // ] — U+1029 O / U+102A AU
        42: ("၏", "ၑ"),   // \ (backslash) — U+104F GENITIVE / U+1051 SSA

        // --- Home တန်း (ASDF...) ---
        0: ("ေ", "ဗ"),    // A — U+1031 VOWEL SIGN E / U+1017 BA
        1: ("ျ", "ှ"),    // S — U+103B MEDIAL YA / U+103E MEDIAL HA
        2: ("ိ", "ီ"),    // D — U+102D VOWEL SIGN I / U+102E VOWEL SIGN II
        // F — ⚠️ သတိထားရန်။ နှစ်ခုလုံး ပုံစံ တူပေမယ့် codepoint မတူဘူး။
        //   plain   = U+103A ASAT (်) — အသတ် (ဥပမာ က်)
        //   shifted = U+1039 VIRAMA (်) — စာလုံး ဆင့်ဖို့ (ဥပမာ က္က)
        // ပုံစံ တူလို့ မှားမပြင်မိအောင် ဒီ စာကြောင်းကိုပဲ \u{...} နဲ့ ရေးထားတယ်။
        3: ("\u{103A}", "\u{1039}"),  // F — U+103A ASAT / U+1039 VIRAMA
        5: ("ါ", "ွ"),    // G — U+102B VOWEL SIGN TALL AA / U+103D MEDIAL WA
        4: ("့", "ံ"),    // H — U+1037 DOT BELOW / U+1036 ANUSVARA
        38: ("ြ", "ဲ"),   // J — U+103C MEDIAL RA / U+1032 VOWEL SIGN AI
        40: ("ု", "ဒ"),   // K — U+102F VOWEL SIGN U / U+1012 DA
        37: ("ူ", "ဓ"),   // L — U+1030 VOWEL SIGN UU / U+1013 DHA
        41: ("း", "ဂ"),   // ; — U+1038 VISARGA / U+1002 GA
        39: ("'", "\""),  // ' — APOSTROPHE / QUOTATION MARK

        // --- အောက်ဆုံး တန်း (ZXCV...) ---
        6: ("ဖ", "ဇ"),    // Z — U+1016 PHA / U+1007 JA
        7: ("ထ", "ဌ"),   // X — U+1011 THA / U+100C TTHA
        8: ("ခ", "ဃ"),   // C — U+1001 KHA / U+1003 GHA
        9: ("လ", "ဠ"),   // V — U+101C LA / U+1020 LLA
        11: ("ဘ", "ယ"),  // B — U+1018 BHA / U+101A YA
        45: ("ည", "ဉ"),  // N — U+100A NNYA / U+1009 NYA
        46: ("ာ", "ဦ"),   // M — U+102C VOWEL SIGN AA / U+1026 UU
        43: (",", "၊"),   // , — COMMA / U+104A LITTLE SECTION
        47: (".", "။"),   // . — FULL STOP / U+104B SECTION
        44: ("/", "?"),   // / — SOLIDUS / QUESTION MARK
    ]

    /// keyCode + Shift ရှိ/မရှိ ပေးရင် ထွက်မယ့် စာလုံး ပြန်ပေးမယ်။
    /// ဇယားထဲမှာ မရှိတဲ့ ခလုတ်ဆိုရင် nil ပြန်မယ်
    /// (အဲဒီ ခလုတ်ကို အတိုင်း လွှဲပေးဖို့)။
    static func output(forKeyCode keyCode: UInt16, shift: Bool) -> String? {
        guard let pair = mappings[keyCode] else { return nil }
        return shift ? pair.shifted : pair.plain
    }
}
