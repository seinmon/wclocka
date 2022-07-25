/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

/**
 * A TimeZone and its readable title, used as the retun type of new time zone view controller.
 */
typealias NewTimezoneRow = (String, TimeZone)

/**
 * Data type containing all the data related to a reminder item.
 */
typealias ReminderDetailsCell = (ReminderViewModel, IndexPath, UIViewController)
