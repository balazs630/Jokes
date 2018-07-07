//
//  JokeTableViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 18..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

class JokeTableViewController: UIViewController {

    // MARK: Properties
    var dataSource: JokesDataSource!
    let jokeNotificationService = JokeNotificationService()
    let refreshControl = UIRefreshControl()

    let noNotificationScheduledView = UIView.loadFromNib(named: UIView.noNotificationScheduledView)
    let waitingForFirstNotificationView = UIView.loadFromNib(named: UIView.waitingForFirstNotificationView)

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Initializers
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIApplicationDidBecomeActive,
                                                  object: nil)
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        jokeNotificationService.delegate = self

        configureTableView()
        setObserverForUIApplicationDidBecomeActive()
    }

    override func viewWillAppear(_ animated: Bool) {
        refreshData()
    }

    // MARK: - Setup
    @objc private func applicationDidBecomeActive() {
        refreshData()
        clearNotificationBadgeNumber()
        refreshNotificationSchedules()
    }

    @objc private func refreshData() {
        jokeNotificationService.moveDeliveredJokesToJokeCollection()
        fetchDeliveredJokes()
        tableView.reloadData()
        refreshControl.endRefreshing()
        presentEmptyView()
    }

    private func fetchDeliveredJokes() {
        dataSource = JokesDataSource(jokes: DBService.shared.getDeliveredJokes(), didBecomeEmpty: didBecomeEmpty())
        tableView.dataSource = dataSource
    }

    private func refreshNotificationSchedules() {
        let generateNewJokesThreshold = 32
        let pendingSchedulesCount = DBService.shared.schedulesCount()

        if pendingSchedulesCount <= generateNewJokesThreshold && pendingSchedulesCount != 0 {
            guard DBService.shared.unusedJokesCount() >= generateNewJokesThreshold else { return }
            jokeNotificationService.setNewRepeatingNotifications()
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
            case SegueIdentifier.showSettings:
                guard let destVC = segue.destination as? SettingsViewController else { return }
                destVC.delegate = self

            case SegueIdentifier.showJoke:
                guard let destVC = segue.destination as? JokeViewController else { return }
                guard let sender = sender as? UITableViewCell else { return }
                guard let selectedIndex = tableView.indexPath(for: sender) else { return }

                guard let jokeCell = tableView.cellForRow(at: selectedIndex) as? JokeCell else { return }
                destVC.jokeText = jokeCell.jokeLabel.text!

            default:
                debugPrint("Unexpected segue identifier was given in: \(#file), line: \(#line)")
            }
        }
    }
}

// MARK: - Screen configurationss
private extension JokeTableViewController {
    private func configureTableView() {
        tableView.dataSource = dataSource
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.white
        refreshControl.backgroundColor = Theme.Color.lightBlue

        tableView.refreshControl = refreshControl
    }

    private func setObserverForUIApplicationDidBecomeActive() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive,
                                               object: nil)
    }

    private func clearNotificationBadgeNumber() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        UserDefaults.standard.set(0, forKey: UserDefaults.Key.badgeNumber)
    }

    private func didBecomeEmpty() -> DidBecomeEmpty {
        return {
            self.presentEmptyView()
        }
    }

    private func presentEmptyView() {
        if dataSource.jokes.isEmpty {
            // Display a message instead of an empty table
            if DBService.shared.isSchedulesListEmpty() {
                displayViewInFrontOfTableView(frontview: noNotificationScheduledView)
            } else {
                displayViewInFrontOfTableView(frontview: waitingForFirstNotificationView)
            }
        } else {
            noNotificationScheduledView.removeFromSuperview()
            waitingForFirstNotificationView.removeFromSuperview()
        }
    }

    private func displayViewInFrontOfTableView(frontview view: UIView) {
        view.frame = self.view.bounds
        tableView.addSubview(view)
        tableView.bringSubview(toFront: view)
    }
}

// MARK: JokeNotificationServiceDelegate
extension JokeTableViewController: JokeNotificationServiceDelegate {
    func notificationDidFire() {
        refreshData()
    }
}

// MARK: SettingsViewControllerDelegate
extension JokeTableViewController: SettingsViewControllerDelegate {
    func startJokeGeneratingProcess() {
        jokeNotificationService.setNewRepeatingNotifications()
    }
}