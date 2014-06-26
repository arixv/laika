/**
 * 
 * 
 * 
 */

(function() {
	tinymce.create('tinymce.plugins.ModionImagePlugin', {
		init : function(ed, url) {
			// Register commands
			ed.addCommand('mceMdnImage', function() {
				
				// Internal image object like a flash placeholder
				if (ed.dom.getAttrib(ed.selection.getNode(), 'class').indexOf('mceItem') != -1)
					return;

				//alert(ed.settings.object_id);
				//alert(ed.settings.object_typeid);
				layer.loadExternal('/admin/?m=photo&action=BackDisplayEmbedModal&object_id='+ed.settings.object_id+'&type_id='+ed.settings.object_id+'&height=window')

			});

			if(ed.settings.object_id !== 0){
				// Register buttons
				ed.addButton('mdnimage', {
					title : 'Embeber en el contenido una imagen relacionada',
					cmd : 'mceMdnImage'
				});
			}
			
		},

		getInfo : function() {
			return {
				longname : 'Modion image',
				author : 'Frooit.com',
				authorurl : 'http://www.frooit.com',
				infourl : 'http://www.modion.org',
				version : tinymce.majorVersion + "." + tinymce.minorVersion
			};
		}
	});

	// Register plugin
	tinymce.PluginManager.add('mdnimage', tinymce.plugins.ModionImagePlugin);
})();


