//= require chosen.jquery


$(function(){
  $('select.chosen').chosen({no_results_text: ' '});
  $('#q_lang_select').on('change',function(){
  	var langChange = this.value;
  	$('.options_(fr)').html(this.value);
  	$.ajax({
  		url: '/admin/global_select_options/'+langChange+'/get_locale',
  		success: function(response){
  			
  		},
  		failure: function(){

  		}
  	})
  })
});

$(function(){
  $('select.chosen').chosen({no_results_text: ' '});
  $('#pre_written_comm').on('change',function(){
    var langChange = this.value;
    $('.sortable body_en').html(this.value);
    $.ajax({
      url: '/admin/prewritten_version_comments/'+langChange+'/get_prewritten_comments',
      success: function(response){
        
      },
      failure: function(){

      }
    })
  })
});




var admin = {

  init: function(){
    admin.set_admin_editable_events();
  },

  set_admin_editable_events: function(){
    var indexId;
    var id;  
    var locale;  
    var update_val;

    $(".admin-editable").live("keypress", function(e){
    
      if ( e.keyCode==27 )
        $( e.currentTarget ).hide();

      if ( e.keyCode==13 ){
        indexId = $(this).attr('indexid');
        id = $(this).attr('second');
        locale = $(this).attr('name');
        update_val = $(this).val();
        var path        = $( e.currentTarget ).attr("data-path");
        var attr        = $( e.currentTarget ).attr("data-attr");
        var resource_id = $( e.currentTarget ).attr("data-resource-id");
        var val         = $( e.currentTarget ).val();
        var urlName     = $(this).attr('url');
        
        val = $.trim(val)
        if (val.length==0)
          val = "&nbsp;";

        $("div#"+$( e.currentTarget ).attr("id")).html(val);
        $( e.currentTarget ).hide();

        var payload = {}
        resource_class = path.slice(0,-1) // e.g. path = meters, resource_class = meter
        payload[resource_class] = {};
        payload[resource_class][attr] = val;

      if (urlName =="PrewrittenVersionComment"){
        urlName = 'prewritten_version_comments/'
        method = "/update_prewritten_comments"
        id = $(this).attr('second');
      }
      else
      {
        urlName = '/admin/global_select_options/'
        method = "/update_global_options"
      }

   
    	$.ajax({
    		url: urlName+locale+method,
    		method: 'get',

    		data: {"indexId":indexId,"update_value":id,"value":update_val,"inline_update":true,"locale":locale},
    		success: function(){

    		},
    		failure:function(){

    		}
    	})
      }
    });

    $(".admin-editable").live("blur", function(e){
      $( e.currentTarget ).hide();
    });
  },

  editable_text_column_do: function(el){
    var input = "input#"+$(el).attr("id")

    $(input).width( $(el).width()+4 ).height( $(el).height()+4 );
    $(input).css({top: ( $(el).offset().top-2 ), left: ( $(el).offset().left-2 ), position:'absolute'});

    val = $.trim( $(el).html() );
    if (val=="&nbsp;")
      val = "";
      
    $(input).val( val );
    $(input).show();
    $(input).focus();
  }
}

$( document ).ready(function() {
  admin.init();
});

function inline_edit_create(id,val,locale,indexId){
  var html_code ="<div id='editable_text_column_"+id+"_"+indexId+"' class='editable_text_column' name="+locale+" ondblclick='admin.editable_text_column_do(this)' indexId="+indexId+" second="+id+" >"+val+"</div>";
  html_code = html_code + "<input data-path='global_select_options_admin_decorators' data-attr='options' data-resource-id='"+id+"' class='editable_text_column admin-editable' id='editable_text_column_"+id+"_"+indexId+"' indexId="+indexId+" second="+id+" name= "+locale+" style='display:none;' />";
  return html_code;
}

function inline_edit_prewritten_comments(id,val,locale){
  var html_code ="<div id='editable_text_column_"+id+"' class='editable_text_column' name= '+locale+' ondblclick='admin.editable_text_column_do(this)' url ='PrewrittenVersionComment' second="+id+" >"+val+"</div>";
  html_code = html_code + "<input data-path='global_select_options_admin_decorators' data-attr='options' data-resource-id='"+id+"' class='editable_text_column admin-editable' url ='PrewrittenVersionComment' id='editable_text_column_"+id+"' second="+id+" name= "+locale+" style='display:none;' />";
  return html_code;
}