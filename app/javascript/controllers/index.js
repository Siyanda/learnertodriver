// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller

import { application } from './application'

import DropdownController from './dropdown_controller.js'
application.register('dropdown', DropdownController)

import MenuController from './menu_controller.js'
application.register('menu', MenuController)

import SidebarController from './sidebar_controller.js'
application.register('sidebar', SidebarController)

import TabsController from './tabs_controller.js'
application.register('tabs', TabsController)

import SlidesController from './slides_controller.js'
application.register('slides', SlidesController)

import DayjsTimeAgoController from './dayjs/time_ago_controller.js'
application.register('dayjs-time-ago', DayjsTimeAgoController)

import DayjsToDurationController from './dayjs/to_duration_controller.js'
application.register('dayjs-to-duration', DayjsToDurationController)

import DayjsFormattedDateTimeController from './dayjs/formatted_date_time_controller.js'
application.register('dayjs-formatted-date-time', DayjsFormattedDateTimeController)
