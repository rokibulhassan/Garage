// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//
//= require sugar-1.2.5.min
//
//= require i18n
//= require i18n/translations
//
//= require amplify
//= require ./requests
//= require twitter/bootstrap
//
//= require chosen.jquery
//= require jcrop
//= require bootstrap/datepicker
//= require bootstrap/bootbox
//
//= require jquery.thumbnailScroller
//= require jquery.autogrow-textarea
//= require jquery.slimScroll
//= require jquery.singularsortable
//
//= require ba-linkify
//
//= require backbone_app


$(document).ready(function () {
    $('a#sucks-message').click(function () {
        var url = $(this).attr('href');
        window.location.replace(url)
    });
});