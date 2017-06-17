// Global custom add-on functions
function handleLookupFilter(id, strType) {
  var strParam = '';
  if (strType == 'region') {
    strParam = 'region_id';
  } else if (strType == 'state') {
    strParam = 'state_id';
  } else if (strType == 'inst') {
    strParam = 'inst_id';
  } else if (strType == 'group') {
    strParam = 'grouping_id';
  }

  if (id.length > 0) {
    location.href = '/list?' + strParam + '=' + id;
  }
  return true;
}

$(document).ready(function() {
  // Don't allow SVG map focus for 508 loss-of-focus issue
  $('svg').attr('focusable','false');
});
