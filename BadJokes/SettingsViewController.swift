//
//  SettingsViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 21..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit
import UserNotifications

protocol SettingsViewControllerDelegate: class {
    func settingsDidClose()
}

class SettingsViewController: UITableViewController, PeriodicityViewControllerDelegate, RecurrenceViewControllerDelegate, TimeViewControllerDelegate {

    @IBOutlet weak var swGlobalOff: UISwitch!
    @IBOutlet weak var swNotificationSound: UISwitch!

    @IBOutlet weak var lblPeriodicity: UILabel!
    @IBOutlet weak var lblRecurrence: UILabel!
    @IBOutlet weak var lblTime: UILabel!

    @IBOutlet weak var sldAnimal: UISlider!
    @IBOutlet weak var sldRough: UISlider!
    @IBOutlet weak var sldIT: UISlider!
    @IBOutlet weak var sldAnti: UISlider!
    @IBOutlet weak var sldTiring: UISlider!
    @IBOutlet weak var sldJean: UISlider!
    @IBOutlet weak var sldMoriczka: UISlider!
    @IBOutlet weak var sldCop: UISlider!
    @IBOutlet weak var sldBlonde: UISlider!

    // For time picker components
    var pckTimeHours = String()
    var pckTimeMinutes = String()
    var lblTimeOptionName = String()

    // Slider IBOutlets and it's UserDefault keys
    var sldCollection: [UISlider:String] {
        return [
            sldAnimal: UserDefaults.Keys.Sld.animal,
            sldRough: UserDefaults.Keys.Sld.rough,
            sldIT: UserDefaults.Keys.Sld.IT,
            sldAnti: UserDefaults.Keys.Sld.anti,
            sldTiring: UserDefaults.Keys.Sld.tiring,
            sldJean: UserDefaults.Keys.Sld.jean,
            sldMoriczka: UserDefaults.Keys.Sld.moriczka,
            sldCop: UserDefaults.Keys.Sld.cop,
            sldBlonde: UserDefaults.Keys.Sld.blonde
        ]
    }

    let defaults = UserDefaults.standard

    weak var delegate: SettingsViewControllerDelegate?

    let notificationWarningIndexPath = IndexPath(item: 0, section: 0)
    var isNotificationEnabled: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        loadPreferences()
        checkNotificationStatus()
    }

    @IBAction func closeSettings(_ sender: Any) {
        savePreferences()
        delegate?.settingsDidClose()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func swGlobalOnOffDidChange(_ sender: Any) {
        disablePreferencesOnGlobalSwitchState()
    }

    @IBAction func openIphoneNotificationSettings(_ sender: Any) {
        UIApplication.shared.open(URL(string:"App-Prefs:root=NOTIFICATIONS_ID")!, options: [:], completionHandler: nil)
    }

    func savePeriodicityWith(selectedCellText: String) {
        lblPeriodicity.text = selectedCellText
    }

    func saveRecurrenceWith(selectedCellText: String) {
        lblRecurrence.text = selectedCellText
    }

    func saveTimeWithSelected(cellText: String) {
        lblTimeOptionName = cellText
        lblTime.text = cellText
    }

    func saveTimeWithSelected(cellText: String, hours: String, minutes: String) {
        lblTime.text = "Pontosan \(hours):\(minutes)-kor"
        lblTimeOptionName = cellText
        pckTimeHours = hours
        pckTimeMinutes = minutes
    }

    func loadPreferences() {
        swGlobalOff.isOn = defaults.bool(forKey: UserDefaults.Keys.Sw.globalOff)
        swNotificationSound.isOn = defaults.bool(forKey: UserDefaults.Keys.Sw.notificationSound)

        lblPeriodicity.text = defaults.string(forKey: UserDefaults.Keys.Lbl.periodicity)
        lblRecurrence.text = defaults.string(forKey: UserDefaults.Keys.Lbl.recurrence)

        if let hours = defaults.string(forKey: UserDefaults.Keys.Pck.timeHours),
            let minutes = defaults.string(forKey: UserDefaults.Keys.Pck.timeMinutes) {
            pckTimeHours = hours
            pckTimeMinutes = minutes
        }

        if defaults.string(forKey: UserDefaults.Keys.Lbl.time) == Time.atGivenTime {
            lblTime.text = "Pontosan \(pckTimeHours):\(pckTimeMinutes)-kor"
            lblTimeOptionName = Time.atGivenTime
        } else {
            lblTime.text = defaults.string(forKey: UserDefaults.Keys.Lbl.time)
            if let text = defaults.string(forKey: UserDefaults.Keys.Lbl.time) {
                lblTimeOptionName = text
            }
        }

        for item in sldCollection {
            item.key.value = defaults.float(forKey: item.value)
        }

        disablePreferencesOnGlobalSwitchState()
    }

    func savePreferences() {
        defaults.set(swGlobalOff.isOn, forKey: UserDefaults.Keys.Sw.globalOff)
        defaults.set(swNotificationSound.isOn, forKey: UserDefaults.Keys.Sw.notificationSound)

        defaults.set(lblPeriodicity.text, forKey: UserDefaults.Keys.Lbl.periodicity)
        defaults.set(lblRecurrence.text, forKey: UserDefaults.Keys.Lbl.recurrence)
        defaults.set(lblTimeOptionName, forKey: UserDefaults.Keys.Lbl.time)

        defaults.set(pckTimeHours, forKey: UserDefaults.Keys.Pck.timeHours)
        defaults.set(pckTimeMinutes, forKey: UserDefaults.Keys.Pck.timeMinutes)
        defaults.synchronize()

        for item in sldCollection {
            defaults.set(item.key.value, forKey: item.value)
            defaults.synchronize()
        }
    }

    func disablePreferencesOnGlobalSwitchState() {
        // If this switch is on, every settings are disabled
        let swGlobalState = !swGlobalOff.isOn

        swNotificationSound.isEnabled = swGlobalState

        lblPeriodicity.isEnabled = swGlobalState
        lblRecurrence.isEnabled = swGlobalState
        lblTime.isEnabled = swGlobalState

        for item in sldCollection {
            item.key.isEnabled = swGlobalState
        }
    }

    func checkNotificationStatus() {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .denied || settings.authorizationStatus == .notDetermined {
                self.isNotificationEnabled = false
            }
        })
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Hide notification warning if the notifications are turned on
        if isNotificationEnabled == true {
            if indexPath.section == notificationWarningIndexPath.section
                && indexPath.row == notificationWarningIndexPath.row {
                cell.isHidden = true
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Set notification warning row height to 0 if the notifications are turned on
        if isNotificationEnabled == true {
            if indexPath.section == notificationWarningIndexPath.section
                && indexPath.row == notificationWarningIndexPath.row {
                return 0
            }
        }

        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if tableView.indexPathForSelectedRow != nil {
            if let segueIdentifier = segue.identifier {

                switch segueIdentifier {
                case SegueIdentifier.periodicityDetail:
                    let destVC = segue.destination as! PeriodicityViewController
                    if let lblPeriodicityText = lblPeriodicity.text {
                        destVC.lastSelectedOption = lblPeriodicityText
                    }
                    destVC.delegate = self
                case SegueIdentifier.recurrenceDetail:
                    let destVC = segue.destination as! RecurrenceViewController
                    if let lblRecurrenceText = lblRecurrence.text {
                        destVC.lastSelectedOption = lblRecurrenceText
                    }
                    destVC.delegate = self
                case SegueIdentifier.timeDetail:
                    let destVC = segue.destination as! TimeViewController
                    destVC.lastSelectedOption = lblTimeOptionName

                    let calendar = Calendar(identifier: .gregorian)
                    var timeComponents = calendar.dateComponents([.hour, .minute], from: Date())
                    timeComponents.hour = Int(pckTimeHours)
                    timeComponents.minute = Int(pckTimeMinutes)

                    destVC.lastSelectedTime = calendar.date(from: timeComponents)!
                    destVC.delegate = self
                default:
                    print("Unexpected segue identifier was given in: \(#file), line: \(#line)")
                }
            }
        }
    }

}
