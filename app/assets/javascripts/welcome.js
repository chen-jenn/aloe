let tooltip = d3.select(".climate-bottom").append("div")
            .attr("class", "tooltip")
            .style("display", "none");

document.addEventListener('DOMContentLoaded', () => {
  // Don't really know what these random groups are, remove them later
  const climateZones = document.querySelectorAll("g:not(#g2065):not(#layer2):not(#viewport-20180630013332566):not(#g1755)");

  function mouseenter(zone) {
    tooltip.style("display", "inline").text(zone);
  }

  function mouseleave() {
    tooltip.style("display", "none");
  }

  // function mousemove() {
  //   tooltip
  //       .text("Tooltip text")
  //       .style("left", (d3.event.pageX - 34) + "px")
  //       .style("top", (d3.event.pageY - 12) + "px");
  // }

  // const ET = document.getElementById('layer5').querySelectorAll("path[inkscape\\:label='ET']")
  climateZones.forEach(element => {
    element.addEventListener("mouseenter", event => {
      const {currentTarget} = event;
      currentTarget.classList.add("highlight");
      mouseenter(currentTarget.id)
    })

    element.addEventListener("mouseleave", event => {
      const {currentTarget} = event;
      currentTarget.classList.remove("highlight");
      mouseleave();
    });

    // element.addEventListener('mousemove', mousemove)
  })

  svgPanZoom(document.getElementById('svg2'));

});
