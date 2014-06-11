//= require ./modal_region
Views.InnerModalRegion = Views.ModalRegion.extend
  el: '#inner-modal'


  showModal: (view)->
    view.on('close', @hideInnerModal, this)
    @$el.modal({
      show: true,
      backdrop: false
    })


  hideInnerModal: ->
    @hideModal()
    $('body').addClass('modal-open')
