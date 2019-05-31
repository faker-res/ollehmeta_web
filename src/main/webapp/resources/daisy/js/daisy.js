//.["!"]..concat..apply..apply..apply..apply
/*
var bono = (function(){
	
	var DatasetFromApiDefaultProperies = {
	
	}
	
	var DatasetFromApi = function(s){
		console.log(s)
	}
	
	return this;
})
*/

var bono = {
	config: {}
};

bono.config.AjaxDefaultProperties = {
	url: "",
	type: "GET",
	dataType: "json",
	formData: {}
}

bono.config.DataSetDefaultProperties = {
	
	render : function(){}
}


bono.DatasetFromApi = function (s, callback) {

	var settings = $.extend({}, bono.config.AjaxDefaultProperties, s);
	console.log(settings)
}

/*
var data = (new Data()).init({})

data.csv({
	url: 'sample/sample.csv',
	type: 'get',
	formData: {
		start: 0,
		end: 10
	}
}, function(dataSet){
	console.log(dataSet)
})

*/


var Data = function () {

	/**
	 * 데이터 초기화 함수
	 * 실제를 로딩하기 위한 함수
	 */
	this.init = function (s) {
		this.createDataSet = s.createDataSet || function(){};
		
		return this;
	}

	this.csv = function (s, callback) {
		var settings = $.extend({}, bono.config.AjaxDefaultProperties, s);
		
		$.ajax({
			type: settings.type,
			url: settings.url,
			data: settings.formData,
			dataType: settings.dataType,
			cache: false,
			contentType: "application/json",
			success: function (data, textStatus, jqXHR) {
				var _data = this.transfromData(data);
				callback(_data);
			},
			error: function (xhr) {
				
			}
		});
	}
	
	this.createDataSet = function(d){return new DataSet(d);}

}


var DataSet = function(d){
	var _data = [];	
	_data.push(d)
	return {
		getData : function(){ return _data},
		addData : function(d){}
	};
}

/*
(new DataView()).init(
	[{ "key": 1000 }],
	{
		domid : "canvas",
		render: function(ds) {
			console.log( ds );
			this.$dom.text(ds[0].key)
		}
	}
)
*/
var DataView = function(){
	
	this.init = function (ds, s) {
		this.ds = ds || {};
		var settings = $.extend({}, bono.config.DataSetDefaultProperties, s); 
		
		this.$dom  	= $("#"+settings.domid);
		this.render = settings.render;
		
		this.render(this.ds)
		
		return this;
	}
	
	this.render = function(){}
	
	return this;
}


var SearchForm = function(){
	
	this.init = function(s) {
		this.$form = $(s.el);
		
		this.focus = s.focus || function(){};
		this.hover = s.hover || function(){};
		this.keypress = s.keypress || function(){};
		this.keyup = s.keyup || function(){};
		this.change = s.change || function(){};
		
		var that = this;
		this.$form.find("input").each(function(){
			that.addEvent($(this))
		});
		return this;
	}
	
	this.addEvent = function($dom) {
		$dom.change(this.change);
		$dom.keyup(this.keyup);
		$dom.keypress(this.keypress);
		$dom.focus(this.focus);
		return this;
	}
	
	this.addButton = function(el, fnClick) {
		$(el).click(fnClick)			   
		return this;
	}
	
	return this;
}










