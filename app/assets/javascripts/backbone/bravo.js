var AwesomePV = new Backbone.Marionette.Application();

AwesomePV.addRegions({
  main: "#awesomepv-app"
});

Backbone.Marionette.Renderer.render = function(template, data){
  if (!JST[template]) throw "Template '" + template + "' not found!";
  return JST[template](data);
}