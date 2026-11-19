import Cocoa
import InputMethodKit

// MARK: - NSManualApplication
//
// storyboard / nib ဖိုင် မသုံးဘဲ AppDelegate ကို ကိုယ်တိုင် ချိတ်ဖို့
// လိုတဲ့ class။ Info.plist ထဲက NSPrincipalClass က ဒီ class ကို
// ညွှန်းထားတယ် — app စဖွင့်တဲ့အခါ macOS က ဒီ class ကို အရင်
// ဖန်တီးပြီး၊ အဲဒီအချိန်မှာ AppDelegate ကို ချိတ်ပေးတယ်။
//
// Reference: ensan-hcl/macOS_IMKitSample_2021
// (InputMethodKit Sample App with macOS 11, Xcode 13, Swift 5.5)
final class NSManualApplication: NSApplication {

    private let appDelegate = AppDelegate()

    override init() {
        super.init()
        delegate = appDelegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - AppDelegate
//
// app ရဲ့ အဓိက ထိန်းချုပ်သူ။ လုပ်တာ ၂ ခု —
//   1. IMKServer ကို စတင်ခြင်း (macOS နဲ့ ချိတ်ဆက်ဖို့)။
//   2. Menu bar icon + menu ကို စီစဉ်ခြင်း (မြ / EN ပြဖို့)။
@main
final class AppDelegate: NSObject, NSApplicationDelegate {

    // IMKServer ကို app သက်တမ်း တစ်လျှောက် မှတ်ထားရမယ်။
    // (ဒီ variable ပျောက်သွားရင် input method အလုပ် မလုပ်တော့ဘူး။)
    private var server: IMKServer?

    private var statusItem: NSStatusItem?
    private var myanmarMenuItem: NSMenuItem?
    private var englishMenuItem: NSMenuItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // 1) IMKServer စတင်ခြင်း။
        // Connection နာမည်ကို Info.plist ထဲက InputMethodConnectionName က ယူမယ်
        // (မရှိရင် bundle ID + "_Connection" လို့ ယူဆမယ်)။
        let connectionName = Bundle.main.infoDictionary?["InputMethodConnectionName"] as? String
            ?? (Bundle.main.bundleIdentifier ?? "com.sai.inputmethod.MyanmarKey") + "_Connection"
        server = IMKServer(name: connectionName, bundleIdentifier: Bundle.main.bundleIdentifier)
        NSLog("MyanmarKey: IMKServer started (connection: %@)", connectionName)

        // 2) Menu bar icon + menu စီစဉ်ခြင်း။
        setupStatusItem()

        // 3) မုဒ် ပြောင်းတိုင်း menu bar ကို ပြန်ပြင်ဖို့ စောင့်မယ်။
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(modeDidChange),
            name: .inputModeDidChange,
            object: nil
        )
    }

    // MARK: - Menu bar

    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        let menu = NSMenu()

        myanmarMenuItem = NSMenuItem(
            title: "မြန်မာ (Myanmar)",
            action: #selector(selectMyanmar),
            keyEquivalent: ""
        )
        englishMenuItem = NSMenuItem(
            title: "English",
            action: #selector(selectEnglish),
            keyEquivalent: ""
        )
        myanmarMenuItem?.target = self
        englishMenuItem?.target = self
        menu.addItem(myanmarMenuItem!)
        menu.addItem(englishMenuItem!)
        menu.addItem(NSMenuItem.separator())

        let aboutItem = NSMenuItem(
            title: "About MyanmarKey…",
            action: #selector(showAbout),
            keyEquivalent: ""
        )
        aboutItem.target = self
        menu.addItem(aboutItem)

        let quitItem = NSMenuItem(
            title: "Quit MyanmarKey",
            action: #selector(quitApp),
            keyEquivalent: "q"
        )
        quitItem.target = self
        menu.addItem(quitItem)

        statusItem?.menu = menu
        updateStatusItem()
    }

    @objc private func modeDidChange() {
        updateStatusItem()
    }

    /// Menu bar icon + menu ကို လက်ရှိ မုဒ်နဲ့ ကိုက်ညီအောင် ပြင်မယ်။
    private func updateStatusItem() {
        switch AppState.shared.mode {
        case .myanmar:
            statusItem?.button?.title = "မြ"
            myanmarMenuItem?.state = .on
            englishMenuItem?.state = .off
        case .english:
            statusItem?.button?.title = "EN"
            myanmarMenuItem?.state = .off
            englishMenuItem?.state = .on
        }
    }

    @objc private func selectMyanmar() {
        AppState.shared.mode = .myanmar
    }

    @objc private func selectEnglish() {
        AppState.shared.mode = .english
    }

    @objc private func showAbout() {
        let alert = NSAlert()
        alert.messageText = "MyanmarKey"
        alert.informativeText = """
        Myanmar (Unicode) input method for macOS.
        Version 0.1.0 (MVP).

        Switch Myanmar / English with Control+Option+M,
        or from this menu.
        """
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }

    @objc private func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
