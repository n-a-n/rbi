BaseView = require '../lib/base_view'
BankTitleView = require './bank_title'
BankSubTitleView = require './configuration_bank_account'

module.exports = class ConfigurationBankView extends BaseView

    className: "unclickable-option"

    tagName: "tr"
    attributes:
        'disabled':'true'

    sum: 0

    subViews: []

    constructor: (@bank) ->
        super()

    addOne: (account) ->
        # add the account
        #console.log 'add one bank view'
        viewAccount = new BankSubTitleView account
        @subViews.push viewAccount
        viewAccount.render()
        @$el.after viewAccount.el
        accountNumber = viewAccount.model.get "accountNumber"
        amount = viewAccount.model.get("amount") or 0
        $(viewAccount.el).after '<tr class="bottom-margin"><td class="bottom-sep">N° ' + accountNumber + '</td><td class="bottom-sep" colspan="3" style="text-align:right;">' + amount.money() +  '</td></tr>'

    render: ->
        # generate the title
        @viewTitle = new BankTitleView @bank
        @$el.html @viewTitle.render().el
        @viewTitle = null
        @sum = 0

        # add accounts
        for account in @bank.accounts.models
            @addOne account

        #preselect if no account number selected
        #accountNumber = window.rbiActiveData.accountNumber or ""
        # if (accountNumber is "") and ($("#account-choice option").length > 1)
        #   $("#account-choice option:eq(1)").attr('selected', 'true').click()
        #   $("#account-choice").change()

        @


    destroy: ->
        @viewTitle?.destroy()
        for view in @subViews
            view.destroy()
        super()