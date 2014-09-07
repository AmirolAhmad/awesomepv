jQuery(document).ready(function($){	
	"use strict";
	
	//tabs
	if($('#myTab').length){
		$('#myTab a').click(function (e) {
			e.preventDefault();
			$(this).tab('show');
		});
	}
	
	//ToolTip
	if($("[data-toggle='tooltip']").length){
		$("[data-toggle='tooltip']").tooltip();
	}
	
	//Carousel
	if($("#carousel").length){
		$('#carousel').flexslider({
			animation: "slide",
			controlNav: false,
			animationLoop: false,
			slideshow: false,
			itemWidth: 131,
			itemMargin: 0,
			asNavFor: '#slider'
		});
	}

    //FlexSlider
	if($("#slider").length){
		$('#slider').flexslider({
			animation: "slide",
			controlNav: false,
			animationLoop: false,
			slideshow: false,
			sync: "#carousel",
			start: function(slider){
			  $('body').removeClass('loading');
			}
		});
	}
	
	//Jscroll Pane
	if($(".latest-vidios").length){
		$('.latest-vidios').jScrollPane();
	}
	
	//Carousel
	if($(".mycarousel").length){
		$('.mycarousel').jcarousel({
			wrap: 'circular'
		});
	}
	
	//Gallery Script
	if($('.gallery_video').length){
		$(".gallery_video a[rel^='prettyPhoto']").prettyPhoto({
			animation_speed: 'slow',
			slideshow: 10000,
			hideflash: true
		});
	}
});

document.createElement('header');
document.createElement('hgroup');
document.createElement('nav');
document.createElement('menu');
document.createElement('section');
document.createElement('article');
document.createElement('aside');
document.createElement('footer');