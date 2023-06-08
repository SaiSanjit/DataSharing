$(document).ready( function() {
    $('#example').DataTable( {
        dom: 'Bfrtip',
      "columnDefs": [
            {
                "targets": [ 0 ],
                "visible": false,
                //"searchable": false
            },
        ],
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]
    } );
} );