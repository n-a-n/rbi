BaseView = require '../lib/base_view'
BankTitleView = require './bank_title'
BankSubTitleView = require './configuration_bank_account'

module.exports = class ConfigurationBankView extends BaseView

    className: "unclickable-option"

    tagName: "option"
    attributes:
        'disabled':'true'

    sum: 0

    subViews: []

    constructor: (@bank) ->
        super()

    addOne: (account) ->
        # add the account
        console.log 'add one bank view'
        viewAccount = new BankSubTitleView account
        @subViews.push viewAccount
        account.view = viewAccount
        @$el.after viewAccount.render().el

    render: ->
        console.log 'render bank view'
        # generate the title
        @viewTitle = new BankTitleView @bank
        @$el.html @viewTitle.render().el
        @viewTitle = null
        @sum = 0

        # add accounts
        for account in @bank.accounts.models
            @addOne account
        @


    destroy: ->
        @viewTitle?.destroy()
        for view in @subViews
            view.destroy()
        super()