//
// AppController
// MacDial
//
// Created by Alex Babaev on 28 January 2022.
//
// Based on Andreas Karlsson sources
// https://github.com/andreasjhkarlsson/mac-dial
//
// License: MIT
//

import AppKit

class AppController: NSObject {
    @IBOutlet private var statusMenu: NSMenu!

    @IBOutlet private var menuSync: NSMenuItem!
    @IBOutlet private var menuSyncOne: NSMenuItem!
    @IBOutlet private var menuSyncTwo: NSMenuItem!

	@IBOutlet private var menuDatabaseConnection: NSMenuItem!
	@IBOutlet private var menuNotionConnection: NSMenuItem!
    @IBOutlet private var menuTopLayer: NSMenuItem!
	
    @IBOutlet private var menuQuit: NSMenuItem!

    private let statusItem: NSStatusItem

    private let settings: UserSettings = .init()

    override init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        super.init()

		updateMenuBarItem()
    }

    override func awakeFromNib() {
        statusItem.menu = statusMenu

		/*
        menuScrollDirection.title = NSLocalizedString("menu.direction", comment: "")
        menuScrollDirectionVert.title = NSLocalizedString("menu.direction.vert", comment: "")
        menuScrollDirectionHorz.title = NSLocalizedString("menu.direction.horz", comment: "")

		menuDatabaseConnection.title = NSLocalizedString("menu.rotationFeedback", comment: "")
        menuQuit.title = NSLocalizedString("menu.quit", comment: "")
		 */

        switch settings.sync {
            case .one:
				syncSelect(item: menuSyncOne)
            case .two:
				syncSelect(item: menuSyncTwo)
        }
	
    }

    func terminate() {
    }

    private func connected(_ serialNumber: String) {
		menuDatabaseConnection.title = String(format: NSLocalizedString("dial.connected", comment: ""), serialNumber)
    }

    private func disconnected() {
		menuDatabaseConnection.title = NSLocalizedString("dial.disconnected", comment: "")
    }

    private func updateMenuBarItem() {
        let selectedImage = NSImage(named: "icon-notion")
        statusItem.button?.image = selectedImage
        statusItem.button?.image?.size = .init(width: 18, height: 18)
        statusItem.button?.imagePosition = .imageLeft
        statusItem.button?.toolTip = "Notion Tools Sync"
    }
	

    @IBAction
    private func syncSelect(item: NSMenuItem) {
		menuSyncOne.state = .off
		menuSyncTwo.state = .off

		switch item.identifier {
            case menuSyncOne.identifier:
				menuSyncOne.state = .on
				settings.sync = .one
            case menuSyncTwo.identifier:
				menuSyncTwo.state = .on
				settings.sync = .two
            default:
                break
        }
    }

    @IBAction
    private func quitTap(_ item: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
