// ===========================
// A donut chart with Protovis
// ===========================
//
// See http://vis.stanford.edu/protovis/ex/pie.html 
//
var Donut = function(dom_id) {
  // Set the default DOM element ID to bind
  if ('undefined' == typeof dom_id)  dom_id = 'chart';
  this.legend_text = null;
  
  var data = function(json) {
    // Set the data for the chart
    this.data = json;
    return this;
  };

   var facet = function(facetname) {
    // Set the facet for the chart
	this.facet = facetname;
    return this;
  };

  var legend = function(texte) {
    // Set the data for the chart
    this.legend_text = texte;
    return this;
  };

  var draw = function() {

          // Sort the data, so the colorization of wedges is preserved with different values
      var entries = this.data.sort( function(a, b) { return a.term < b.term ? -1 : 1; } ),
          // Create an array holding just the values (counts)
          values  = pv.map(entries, function(e) { return e.count; });
      // console.log('Drawing', entries, values);
	 var legend_text = this.legend_text;
	 var facet_name = this.facet;
	 
          // Set-up dimensions and color scheme for the chart
      var w = 200,
          h = 200,
          colors = pv.Colors.category10().range();

          // Create the basis panel
      var vis = new pv.Panel()
          .width(w)
          .height(h)
          .margin(20)
          .left(20)
          .right(20)
          .top(40);

		   // Create the "wedges" of the chart
      vis.add(pv.Wedge)
          // Set-up auxiliary variable to hold state (mouse over / out)
          .def("active", -1)
          // Pass the normalized data to Protovis
          .data( pv.normalize(values) )
          // Set-up chart position and dimension
          .left(w/3)
          .top(w/3)
          .outerRadius(w/2.5)
          // Create a "donut hole" in the center of the chart
          .innerRadius(5)
          // Compute the "width" of the wedge
          .angle( function(d) { return d * 2 * Math.PI; } )
          // Add white stroke
          .strokeStyle("#fff")
		  .lineWidth(2)

          // On "mouse over", set the relevant "wedge" as active
          .event("mouseover", function() {
             this.active(this.index);
             this.cursor('pointer');
             return this.root.render();
           })
           // On "mouse out", clear the active state
           .event("mouseout",  function() {
             this.active(-1);
             return this.root.render();
           })
           // On "mouse down", perform action, such as filtering the results...
           .event("mousedown", function(d) {
             var term = entries[this.index].term;
			 addFilter(facet_name, term);
			 filterLegend = "#" + dom_id + "_filter";
			 $( filterLegend )
				.text(term)
				.click(function() {
					removeFilter(facet_name);
					filterLegend = "#" + dom_id + "_filter";
					$( filterLegend ).text("");
					// Simulate a keyup event
					$( "#searchterm" ).trigger('keyup');
				});
				
			// Simulate a keyup event
			$( "#searchterm" ).trigger('keyup');
           })

           // Add the left part of he "inline" label, displayed inside the donut "hole"
           .anchor("right").add(pv.Dot)
            // The label is visible when the corresponding "wedge" is active
            .visible( function() { return this.parent.children[0].active() == this.index; } )
            .fillStyle("#222")
            .lineWidth(0)
            .radius(14)

           // Add the middle part of the label
           .anchor("center").add(pv.Bar)
            .fillStyle("#222")
            .width(function(d) {                                // Compute width:
              return (d*100).toFixed(1).toString().length*4 +   // add pixels for percents
                     10 +                                       // add pixels for glyphs (%, etc)
                     (entries[this.index].term.length*9);       // add pixels for letters (very rough)
            })
            .height(28)
            .top((w/3)-14)

           // Add the right part of the label
           .anchor("right").add(pv.Dot)
            .fillStyle("#222")
            .lineWidth(0)
            .radius(14)

           // Add the text to label
           .parent.children[2].anchor("left").add(pv.Label)
            .left((w/3)-7)
            .text(function(d) {
              // Combine the text for label
              return (d*100).toFixed(1) + "%" + ' ' +
                     entries[this.index].term + ' (' + values[this.index] + ')';
            })
            .textStyle("#fff");

			
			vis.add(pv.Label)
				.top(-20)
				.left(40)
				.textAlign("center")
				.text(function() {
					var first = entries[0];
					if (first) return legend_text;
					else return null;
				})
				.textStyle("#B1B1B1");


			
          // Bind the chart to DOM element
          vis.root.canvas(dom_id)
          // And render it.
          .render();
  };

  // Create the public API
  return {
    data   : data,
    facet  : facet,
    legend : legend,
    draw   : draw
  };

};
