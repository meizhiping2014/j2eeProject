// JavaScript Document

/*  Author: Stone  
	Date:******
*/

;(function($){
	$.fn.extend({
		"addDynamicRow":function(){
			//minRow="1" minRowMsg="" maxRow="10" maxRowMsg="" currentRowIndex="0" templateId="templete_project" parentRowIndex="0"
			var minRow = parseInt(this.attr("minRow"));
			var maxRow = parseInt(this.attr("maxRow"));
			var templateId = this.attr("templateId");
			var currentRowIndex = parseInt(this.attr("currentRowIndex"));
			var parentRowIndex = this.attr("parentRowIndex");

			if(this.children().size() >= maxRow){
				alert("超过限制了,不能增加");
				return;
			}
	
			var html = $("#" + templateId).html() + '';
			html = html.replace(new RegExp("{index}", "g"), currentRowIndex);
		
			if(parentRowIndex){
				html = html.replace(new RegExp("{pindex}", "g"), parentRowIndex);
			}
		
			this.append($(html));
		
			this.attr("currentRowIndex", currentRowIndex + 1);
			},
			
		"removeDynamicRow":function(id){
			var minRow = parseInt(this.attr("minRow"));
			if(this.children().size() <= minRow){
				alert("至少保留一条记录！");
				return;
			}
				$("#" + id, this).remove();
			}
	});
})(jQuery);