AppView = require 'views/app'

BanksCollection = require 'collections/banks'
BankOperationsCollection = require 'collections/bank_operations'
BankAmountsCollection = require 'collections/bank_amounts'

module.exports =

    initialize: ->

        # set globals app, collections, data
        window.app = @
        window.collections = {}
        window.views = {}
        window.rbiActiveData = {}

        #set global active data
        window.rbiActiveData.currency =
            name : 'euro'
            entity : '&euro;'

        #set global rbi color for dynamic use
        window.rbiColors =
            border_color : "#efefef"
            grid_color : "#ddd"
            default_black : "#666"
            green : "#8ecf67"
            yellow : "#fac567"
            orange : "#F08C56"
            blue : "#87ceeb"
            red : "#f74e4d"
            teal : "#28D8CA"
            grey : "#999999"



        #instantiate collections: banks, operations, amounts
        window.collections.allBanks = new BanksCollection()
        window.collections.banks = new BanksCollection()
        window.collections.operations = new BankOperationsCollection()
        window.collections.amounts = new BankAmountsCollection()

        ###
                views
        ###
        # this one is tricky - it lays down the structure, so it needs to be rendered
        # before any other view using that structure
        window.views.appView = new AppView()
        window.views.appView.render()

        window.activeObjects = {}
        _.extend(window.activeObjects, Backbone.Events);


        # Routing management
        Router = require 'router'
        @router = new Router()

        # Makes this object immuable.
        Object.freeze this if typeof Object.freeze is 'function'