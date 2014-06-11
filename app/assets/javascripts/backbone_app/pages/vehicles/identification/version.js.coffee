//=require ./identification
class Fragments.Vehicles.Identification.Version extends Backbone.Marionette.Layout
  getTemplate: ->
    basePath = 'fragments/vehicles/version'
    if @vehicle.isAuto()
      "#{basePath}_car"
    else
      "#{basePath}_bike"

  tagName: 'tbody'

  regions:
    generation: "#generationContainer"
    ownership:  "#ownership"

  events:
    'change .attribute'            : 'saveVersion'
    'change .production-row'       : 'saveProductionRow'
    'mouseenter  .add-select-options'  : 'showPopover'
    'mouseleave  .popover'             : 'hidePopover'
    'click .chzn-container'            : 'hidePopovers'
    'click .add-select-option'     : 'addSelectOption'
    'click .remove-select-option'  : 'removeSelectOption'

  initialize: ({@vehicle, @versionAttributes, @generations})->
    @firstVersion = @versionAttributes.get('first_version')
    @modelId = @versionAttributes.get('model_id')
    @versionAttributes.unset('model_id')
    @globalSelectOptions = @versionAttributes.get('global_select_options')
    @globalSelectOptionsTranslations = @versionAttributes.get('global_select_options_translations')
    @globalSelectOptionsNeedTranslating = @globalSelectOptionsTranslations?
    modelSelectOptions = @versionAttributes.get('model_select_options')
    if !$.isEmptyObject(modelSelectOptions)
      @modelSelectOptions = new Collections.ModelSelectOptions(modelSelectOptions)
    else
      @modelSelectOptions = new Collections.ModelSelectOptions()
    @setBindings()
    @versionAttributesFetchRequests = 0

  setBindings: ->
    @bindTo @model, 'change:body', =>
      @fetchAttributeSet(['name', 'second_name'])

    @bindTo @model, 'change:name', =>
      @fetchAttributeSet(['production_year', 'energy'])

    @bindTo @model, 'change:production_year', =>
      @fetchAttributeSet(['transmission_numbers', 'production_code'])

    @bindTo @model, 'change:transmission_numbers', =>
      @fetchAttributeSet(['transmission_type'])

    @bindTo @model, 'change:transmission_type', =>
      MyApp.vent.trigger '[version]change:transmission_type'

  onRender: ->
    @initPopovers()
    if @versionAttributesFetchRequests is 0
      that = @

      callback = =>
        @$('.addable-chosen').chosen
          no_results_text: ' '
          create_option_text: I18n.t('create_option_text', scope: 'chosen')
          create_option: (value) ->
            @.append_option value: value, text: value
            field = $(@form_field)
            if field.prop('name') in ['production_year']
              that.versionAttributes.get(field.prop('name')).add(parseInt value)
            else
              that.versionAttributes.get(field.prop('name')).add(value)

            field.trigger 'change'

        @$('.attribute-checkbox').on 'change', (e) =>
          $target = $(e.currentTarget)
          @model.set($target.attr('name'), $target.is(':checked'))
          promise = @model.save()
          promise.done => @render()

        @$('.chosen').chosen(no_results_text: ' ')

        if @generation
          @generation.show new Fragments.Vehicles.Identification.Version.Generation
            model: @model.get('generation')
            generations: @generations
            showControls: Models.Ability.canManageVehicle @vehicle

        new Fragments.Vehicles.Identification.Ownership(
          model: @vehicle.get 'ownership'
          el: @ownership.el).render()
      _.defer(callback)

  saveVersion: ->
    @model.save @collectVersionData(), wait: true

  fetchAttributeSet: (attributes)->
    return @render() if @firstVersion
    @versionAttributesFetchRequests += 1
    @model.save {},
      silent: true
      success: =>
        @versionAttributes.fetch data: {attributes: attributes}, success: =>
          @versionAttributesFetchRequests -= 1
          @render()

  saveProductionRow: ->
    @model.save @collectProductionRowData(),
      silent: true
      wait: true
      success: =>
        @render()

  initPopovers: ->
    that = @
    @$('.add-select-options').each ->
      attr = $(this).data('attr')
      $(this).popover(
        placement: 'right'
        html: true
        trigger: 'manual'
        content: ->
          that.contentForPopover(attr)
      )

  contentForPopover: (attr) ->
    options = @modelSelectOptions.find (model) ->
      model.get('name') is attr
    options = options?.get('options') || []
    nonChosen = _.difference(@stringAttrs(@globalSelectOptions[attr]), @stringAttrs(options))
    selectsTranslations = if @globalSelectOptionsNeedTranslating then @globalSelectOptionsTranslations else null
    JST['fragments/vehicles/popover_select_options'](allSelects: @globalSelectOptions[attr], nonChosenSelects: nonChosen, selectsTranslations: selectsTranslations, attr: attr)

  showPopover: (e) ->
    $target = $(e.currentTarget)
    if $target.siblings('.popover').length is 0
      @hidePopovers()
      $target.popover('show')

  hidePopover: (e) ->
    $(e.currentTarget).siblings('.add-select-options').popover('hide')

  hidePopovers: ->
    @$('.popover').remove()

  addSelectOption: (e) ->
    $target = $(e.currentTarget)
    attr = $target.closest('ul').data('attr')
    option = $target.data('option').toString()
    optionDisplay = $.trim($target.text())
    @addOption attr, option, success: =>
      $select = @$("select[name=#{attr}]")
      $select.append("<option value=\"#{option}\">#{optionDisplay}</option>")
      $select.trigger('liszt:updated')
      $target.removeClass('add-select-option').addClass('chosen-select-option')
      text = $target.text()
      $target.html($("<a class=\"remove-select-option\" style=\"cursor: pointer;\">&times;</a><span>#{text}</span>"))
    false

  addOption: (attr, value, opts) ->
    option = @modelSelectOptions.find (model) ->
      model.get('name') is attr
    unless option
      option = new Models.ModelSelectOption
        model_id: @modelId
        name: attr
        options: []
    option.get('options').push(value)
    option.save {}, success: =>
      @modelSelectOptions.add(option)
      opts.success()

  removeSelectOption: (e) ->
    $target = $(e.currentTarget)
    $chosen = $target.closest('.chosen-select-option')
    attr = $chosen.closest('.popover-global-selects').data('attr')
    value = $chosen.data('option').toString()
    @removeOption attr, value, success: =>
      $select = $target.closest('td').find('select.attribute')
      $select.find("option[value='#{value}']").remove()
      $select.trigger('liszt:updated')
      @hidePopovers()
    false

  removeOption: (attr, value, opts) ->
    remove = (el) -> el.toString() is value
    option = @modelSelectOptions.find (model) ->
      model.get('name') is attr
    option.set 'options', _.reject(option.get('options'), remove)
    option.save {}, wait: true, success: ->
      opts.success()

  stringAttrs: (ary) ->
    ary.map (e) -> e.toString()

  selectOptionsForAttr: (attr) ->
    modelSelectOption = @modelSelectOptions.find (model) ->
      model.get('name') is attr
    return [] unless modelSelectOption
    modelSelectOption.get('options')

  # includes current attribute even if it isn't in the possible set of
  # selectable attributes
  selectOptionsForAttrWithCurrent: (attr) ->
    selectOptions = @selectOptionsForAttr(attr)
    attrVal = @model.get(attr)
    return selectOptions if attrVal is null
    selectOptions.push(attrVal) unless _.include(@stringAttrs(selectOptions), attrVal.toString())
    selectOptions

  collectVersionData: ->
    body:                 @$('#version_body_id').val()
    name:                 @$('#name_id').val()
    second_name:          @$("#second_name_id").val()
    transmission_numbers: @$('#version_transmission_numbers_id').val()
    transmission_type:    @$('#version_transmission_type_id').val()
    production_year:      @$('#production_year_id').val()
    doors:                @$('#version_doors').val()
    energy:               @$('#version_energy').val()
    transmission_details: @$('#version_transmission_details').val()

  collectProductionRowData: ->
    production_code:      @$('#production_code_id').val()
    market_version_name:  @$('#market_version_name_id').val()

  defaultProductionYears: ->
    _.range(1920, (new Date().getFullYear() + 2)).reverse()

  serializeData: ->
    brand:                 @vehicle.get 'brand'
    model:                 @vehicle.get 'model'
    user:                  @vehicle.get 'user'
    version:               @model
    vehicle:               @vehicle
    bodyOptions:           @selectOptionsForAttr('body')
    bodyOptionsWithCur:    @selectOptionsForAttrWithCurrent('body')
    doorOptions:           @selectOptionsForAttr('doors')
    doorOptionsWithCur:    @selectOptionsForAttrWithCurrent('doors')
    transmissionNumbersOptions: @selectOptionsForAttr('transmission_numbers')
    transmissionNumbersOptionsWithCur: @selectOptionsForAttrWithCurrent('transmission_numbers')
    transmissionTypeOptions:    @selectOptionsForAttr('transmission_type')
    transmissionTypeOptionsWithCur: @selectOptionsForAttrWithCurrent('transmission_type')
    transmissionDetailsOptions: @selectOptionsForAttr('transmission_details')
    transmissionDetailsOptionsWithCur: @selectOptionsForAttrWithCurrent('transmission_details')
    energyOptions:         @selectOptionsForAttr('energy')
    energyOptionsWithCur:  @selectOptionsForAttrWithCurrent('energy')
    firstVersion:          @firstVersion
    globalSelectOptions:   @globalSelectOptions
    globalSelectOptionsNeedTranslating: @globalSelectOptionsNeedTranslating
    globalSelectOptionsTranslations: @globalSelectOptionsTranslations
    attributes:            @versionAttributes
    productionYears:       @defaultProductionYears()
    showControls:          Models.Ability.canManageVehicle @vehicle
    showBody:              Models.Ability.canShowIdentificationRow @vehicle, 'body'
    showModelVersionData:  Models.Ability.canShowIdentificationRow @vehicle, 'modelVersion'
    showMarketRow:         Models.Ability.canShowIdentificationRow @vehicle, 'market'
    showProductionCodeRow: Models.Ability.canShowIdentificationRow @vehicle, 'productionCode'
    showProductionYearRow: Models.Ability.canShowIdentificationRow @vehicle, 'productionYear'
    showGenerationRow:     Models.Ability.canShowIdentificationRow @vehicle, 'generation'
    showGearboxRow:        Models.Ability.canShowIdentificationRow @vehicle, 'gearBox'
    showGearboxTypeData:   Models.Ability.canShowIdentificationRow @vehicle, 'gearBoxType'
    showTransmissionRow:   Models.Ability.canShowIdentificationRow @vehicle, 'transmission'
    showEnergyRow:         Models.Ability.canShowIdentificationRow @vehicle, 'energy'
    showOwnershipRows:     Models.Ability.canShowIdentificationRow @vehicle, 'ownership'
    aliases:               @vehicle.aliases()

