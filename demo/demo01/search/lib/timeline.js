// ===========================
// A timeline chart with Protovis
// ===========================
//
// See http://vis.stanford.edu/protovis/ex/area.html
//
var Timeline = function(dom_id) {
  // Set the default DOM element ID to bind
  if ('undefined' == typeof dom_id)  dom_id = 'chart';

  var data = function(json) {
    // Set the data for the chart
    this.data = json;
    return this;
  };

  var draw = function() {

          // Set-up the data
      var entries = this.data;
          // Add the last "blank" entry for proper timeline ending
          entries.push({ count : entries[entries.length-1].count });
          // console.log('Drawing, ', entries);

          // Set-up dimensions and scales for the chart
      var w = 300,
          h = 150,
          max = pv.max(entries, function(d) { return d.count;}),
          x = pv.Scale.linear(0, entries.length-1).range(0, w),
          y = pv.Scale.linear(0, max).range(0, h);

          // Create the basis panel
      var vis = new pv.Panel()
          .width(w)
          .height(h)
          .bottom(20)
          .left(20)
          .right(40)
          .top(40);

           // Add the chart legend at top left
       vis.add(pv.Label)
           .top(-20)
           .text(function() {
             var first = new Date(entries[0].time);
             var last  = new Date(entries[entries.length-2].time);
             return "Talks de " +
                    first.getFullYear() +
                    " à " +
                    last.getFullYear();
            })
           .textStyle("#B1B1B1")

           // Add the X-ticks
       vis.add(pv.Rule)
           .data(entries)
           .visible(function(d) {return d.time;})
           .left(function() { return x(this.index); })
           .bottom(-15)
           .height(15)
           .strokeStyle("#33A3E1")
           // Add the tick label (DD/MM)
           .anchor("right").add(pv.Label)
            .text(function(d) { var date = new Date(d.time); return date.getFullYear(); })
            .textStyle("#2C90C8")
            .textMargin("5")

			/*
           // Add the Y-ticks
       vis.add(pv.Rule)
           // Compute tick levels based on the "max" value
           .data(y.ticks(max))
           .bottom(y)
           .strokeStyle("#eee")
           .anchor("left").add(pv.Label)
            .text(y.tickFormat)
            .textStyle("#c0c0c0")
			*/

           // Add container panel for the chart
       vis.add(pv.Panel)
           // Add the area segments for each entry
          .add(pv.Area)
            // Set-up auxiliary variable to hold state (mouse over / out) 
           .def("active", -1)
           // Pass the data to Protovis
           .data(entries)
           .bottom(0)
           // Compute x-axis based on scale
           .left(function(d) {return x(this.index);})
           // Compute y-axis based on scale
           .height(function(d) {return y(d.count);})
           // Make the chart curve smooth
           .interpolate('cardinal')
           // Divide the chart into "segments" (needed for interactivity)
           .segmented(true)
//		   .fillStyle(function(d) "rgb(" + parseInt((d.count / max * 100) + 100) + "," + parseInt((d.count / max * 100) + 100) + "," + 255 + ")")
 		.fillStyle("#79D0F3")

           // On "mouse over", set the relevant area segment as active
           .event("mouseover", function() {
             this.active(this.index);
             return this.root.render();
           })
           // On "mouse out", clear the active state
           .event("mouseout",  function() {
             this.active(-1);
             return this.root.render();
           })
           // On "mouse down", perform action, such as filtering the results...
           .event("mousedown", function(d) {
             var time = entries[this.index].time;
             // return (alert("Timestamp: '"+time+"'"));
           })

          // Add thick stroke to the chart
          .anchor("top").add(pv.Line)
           .lineWidth(3)
           .strokeStyle('#33A3E1')

          // Add the circle "label" displaying the count for this day
          .anchor("top").add(pv.Dot)
           // The label is only visible when area segment is active
           .visible(function() { return this.parent.children[0].active() == this.index; } )
           .left(function(d) {return (x(this.index)+x(this.index+1))/2;})
           .bottom(function(d) {return y(d.count)/2;})
           .fillStyle("#33A3E1")
           .lineWidth(0)
           .radius(15)
           // Add text to the label
          .anchor("center").add(pv.Label)
           .text(function(d) {return d.count;})
           .textStyle("#E7EFF4")

           // Bind the chart to DOM element
          .root.canvas(dom_id)
           // And render it.
          .render();
  };

  // Create the public API
  return {
    data   : data,
    draw   : draw
  };

};
