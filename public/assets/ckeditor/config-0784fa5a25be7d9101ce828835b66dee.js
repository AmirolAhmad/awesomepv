(function() {
  CKEDITOR.editorConfig = function(config) {
    config.language = 'en';
    config.height = '600';
    config.toolbar_Pure = [
      {
        name: 'insert',
        items: ['Image']
      }
    ];
    config.toolbar = 'Pure';
    return true;
  };

}).call(this);
