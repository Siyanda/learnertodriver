import { application } from "../../javascript/controllers/application"
import BotCheck from "./forms/bot_check/controller"
import DateTime from "./utils/date_time/controller"

application.register("forms--bot-check", BotCheck)
application.register("utils--date-time", DateTime)
