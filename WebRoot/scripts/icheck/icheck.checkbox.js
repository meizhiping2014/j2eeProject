/**
author:ben
**/
;(function($){
	$.fn.extend({
		// 全选
		checkAll:function(){
			var minRow = parseInt(this.attr('minRow'));
			var maxRow = parseInt(this.attr('maxRow'));
			var templateId = this.attr('templateId');
			var currentRowIndex = parseInt(this.attr('currentRowIndex'));
			var parentRowIndex = this.attr('parentRowIndex');
			
			$(this).on('ifChecked', function(event){
			
				var cb = $('tbody tr', $(this).parents('table')).find('input[type=checkbox]')
				if(cb.length){
					cb.parents('tr').addClass('selected');
					cb.iCheck('check');
				}
				
			});

		},
		// 反选
		uncheckAll:function(){
			$(this).on('ifUnchecked', function(event){
			
				var cb = $('tbody tr', $(this).parents('table')).find('input[type=checkbox]')
				if(cb.length){
					cb.parents('tr').removeClass('selected');
					cb.iCheck('uncheck');
				}
				
			});
		},
		
		// 单选
		check:function($checkall,_func){
			$(this).on('ifChecked', function(event){
			
				$(this).parents('tr').addClass('selected');
				// 判断是否所有行都已选择						
				var flag = true;
				$checkall.parents('table').find('tbody tr').find('input[type="checkbox"]').each(function(){
					var cb = $(this);
					if(cb.length && !cb.prop('checked')){
						flag = false;
						return false;
					}
				});
				
				
				// 如果所有行都已选择，则将全选按钮置为选中
				if(flag)
					$checkall.iCheck('check');
				
				if(_func)
					_func();
				
			});
		},
		// 单选（反选）
		uncheck:function($checkall,_func){
		
			$(this).on('ifUnchecked', function(event){
			
				$(this).parents('tr').removeClass('selected');
				$checkall.iCheck('indeterminate');
				
				if(_func)
					_func();
				
			});
		},
		onEventInit:function(){
		
			$(this).on('click', 'tr', function () {
			
	        	var $tr = $(this);
	        	
	        	if($tr.find('input[type="checkbox"]').length)
				    $tr.find('input[type="checkbox"]').iCheck((!$tr.hasClass('selected') ? 'check' : 'uncheck'));
        		
		    });
		    
		}
	});
})(jQuery);