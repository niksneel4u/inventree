require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require ('jquery.matchHeight.min')
require ('jquery.validate.min')
require ('bootstrap.min')
require ('main')
require ('form_validation')

global.$ = jQuery;

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))
