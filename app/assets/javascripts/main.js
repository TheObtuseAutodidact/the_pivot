$(document).ready(function(){
  collapseTable()
  slider()
  $('select:not([multiple])').material_select();
});

function collapseTable() {
  $('.platform-admin-tables').on('click', function() {
    $(this).next().toggleClass('hidden');
  });
};
