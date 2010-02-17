// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Ajax.Base.prototype.initialize = Ajax.Base.prototype.initialize.wrap(
        function(p, options){
                p(options);
                this.options.parameters = this.options.parameters || {};
                this.options.parameters.authenticity_token = encodeURIComponent(AUTH_TOKEN);
        }
);


function update_business(element, value){
  business_id = element.id.split("_")[1];
  new Ajax.Request(
    '/admin/businesses/' + business_id + ".js", { 
        asynchronous: true,
        evalScripts: true,
        method: 'put',
        parameters: {'business[mailing_required]': value}
    });  
}

function delete_business(event) {
  conf = confirm("Are you sure? This business and its contribution, if it has one, will be destroyed.")
  if(conf){
    business_id = event.srcElement.parentNode.parentNode.id.split("_")[1];
    new Ajax.Request(
      '/admin/businesses/' + business_id + ".js", { 
          asynchronous: true,
          evalScripts: true,
          method: 'delete'
    });  
    
    console.debug("Deleted business#"+business_id);
  }
}

function set_totals(){
  var responded_businesses_count_td = $("responded_businesses_count");
  var other_businesses_count_td = $("other_businesses_count");
  if(responded_businesses_count_td){
    responded_businesses_count_td.innerHTML = responded_businesses_count_td.up('tfoot').next('tbody').select('tr').length + ' businesses';
  }
  if(other_businesses_count_td){
    other_businesses_count.innerHTML = other_businesses_count_td.up('tfoot').next('tbody').select('tr').length + ' businesses';
  }
}

