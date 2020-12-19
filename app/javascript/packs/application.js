require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("@rails/actiontext");
require("channels");
require("trix");

const images = require.context('../images', true);
import "stylesheets/application";

import "./helpers/indexdb.js";
import "./helpers/numbers.js";
import "./helpers/time_date.js";
import "./utils/pwa.js";
import "./utils/service_worker.js";