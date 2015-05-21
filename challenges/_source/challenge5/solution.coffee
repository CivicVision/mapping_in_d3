width = 800
height = 600
center = [5,70]
scale = 600
projection = d3.geo.mercator().scale(scale).translate([width/2, 0]).center(center)
path = d3.geo.path().projection(projection)

svg = d3.select("#map").append("svg").attr("height", height).attr("width", width)
countries = svg.append("g")

scale = d3.scale.quantile().range(colorbrewer.Reds[8])

d3.json "data/eu.geojson", (data) ->
  scale.domain(d3.extent(data.features, (d) -> parseInt(d.properties.pop_est)))
  country = countries.selectAll('.country')
  .data(data.features)
  .enter()
  .append('path')
  .attr('class', 'country')
  .attr('d', path)

  countries.selectAll('.subuni-label')
  .data(data.features)
  .enter()
  .append("text")
  .attr("class", (d) -> "subunit-label " + d.id)
  .attr("transform", (d) -> "translate(" + path.centroid(d) + ")")
  .attr("dy", ".35em")
  .text((d) -> d.properties.name )
  return
