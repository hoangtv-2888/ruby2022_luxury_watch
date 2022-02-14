// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

require("./jquery-1.11.0.min")
require("./flexslider.js")
require("./imagezoom.js")
require("./memenu.js")
require("./jquery.easydropdown.js")
require("./custom.js")
require("jquery")
require("@nathanvda/cocoon")
import "bootstrap/dist/css/bootstrap"
import "bootstrap/dist/js/bootstrap"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import I18n from "i18n-js"
window.I18n = I18n
