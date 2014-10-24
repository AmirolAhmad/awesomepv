// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//= require jquery.dataTables
//= require dataTables.bootstrap
//= require slick
//= require jquery.magnific-popup
//= require turbolinks
//= require_tree .

function PopupCenter(pageURL, title,w,h) {
var left = (screen.width/2)-(w/2);
var top = (screen.height/2)-(h/2);
var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
} 

$(document).ready(function(){
  $(".btn").tooltip({
    placement : 'bottom',
    container: 'body'
  });

  $('.one-time').slick({
    dots: false,
    infinite: true,
    speed: 300,
    slidesToShow: 4,
    touchMove: false,
    slidesToScroll: 1
  });

  $('.img-item').hover( function() {
      $(this).find('.img-title').fadeIn(300);
  }, function() {
      $(this).find('.img-title').fadeOut(100);
  });
});