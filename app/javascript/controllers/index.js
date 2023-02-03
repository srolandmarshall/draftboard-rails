// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import DraftController from "./draft_controller"
application.register("draft", DraftController)

import DraftpickController from "./draftpick_controller"
application.register("draftpick", DraftpickController)

import FirestoreController from "./firestore_controller"
application.register("firestore", FirestoreController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)
