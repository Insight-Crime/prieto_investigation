const margin = {top: 30, right: 30, bottom: 60, left: 50},
    width = 640 - margin.left - margin.right,
    height = 730 - margin.top - margin.bottom;

// append the svg object to the body of the page
const svg = d3.select("#prieto_bar_chart")
    .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform",`translate(${margin.left},${margin.top})`);

// Parse the Data
d3.csv("https://raw.githubusercontent.com/newton-c/prieto_investigation/main/data/d3_data.csv").then( function(data) {

    // List of subgroups = header of the csv files = soil condition here
    const subgroups = data.columns.slice(1)

    // List of groups = species here = value of the first column called group -> I show them on the X axis
    const groups = data.map(d => d.year)

    console.log(groups)

    // Add X axis
    const x = d3.scaleBand()
        .domain(groups)
        .range([0, width])
        .padding([0.2])
    svg.append("g")
    .attr("class", "x-axis")
    .attr("transform", `translate(0, ${height})`)
    .call(d3.axisBottom(x)
    .tickSizeInner(3)
    .tickSizeOuter(0))

    // Add Y axis
    const y = d3.scaleLinear()
    .domain([0, 160])
    .range([ height, 0 ]);
    svg.append("g")
    .attr("class", "y-axis")
    .call(d3.axisLeft(y)
    .tickSizeInner(-width)
    .tickSizeOuter(0)
    .tickValues([5, 10, 15, 20, 140, 145, 150]))

    // Another scale for subgroup position?
    const xSubgroup = d3.scaleBand()
    .domain(subgroups)
    .range([0, x.bandwidth()])
    .padding([0.05])

    // color palette = one color per subgroup
    const color = d3.scaleOrdinal()
    .domain(subgroups)
    .range(['#374F98', '#C53630'])

    // Show the bars
    svg.append("g")
    .selectAll("g")
    // Enter in data = loop group per group
    .data(data)
    .join("g")
        .attr("transform", d => `translate(${x(d.year)}, 0)`)
    .selectAll("rect")
    .data(function(d) { return subgroups.map(function(key) { return {key: key, value: d[key]}; }); })
    .join("rect")
        .attr("x", d => xSubgroup(d.key))
        .attr("y", d => y(d.value))
        .attr("width", xSubgroup.bandwidth())
        .attr("height", d => height - y(d.value))
        .attr("fill", d => color(d.key));

// adding titles and labels
svg.append("text")
    .attr("class", "plot-title")
    .attr("x", 0)
    .attr("y", 285)
    .text("Reported Police Abuse During the Prieto")
    
svg.append("text")
    .attr("class", "plot-title")
    .attr("x", 0)
    .attr("y", 315)
    .text("Administrations")

svg.append("text")
    .attr("class", "plot-subtitle")
    .attr("x", 0)
    .attr("y", 355)
    .text("Security forces under Prieto’s control were notorious for")

svg.append("text")
    .attr("class", "plot-subtitle")
    .attr("x", 0)
    .attr("y", 380)
    .text("abusing their power, attacking journalists, protestors,")

svg.append("text")
    .attr("class", "plot-subtitle")
    .attr("x", 0)
    .attr("y", 405)
    .text("and his personal rivals.")

svg.append("text")
    .attr("class", "y-axis-title")
    .attr("transform", "translate(0," + height + ")")
    .attr("x", -480)
    .attr("y", -35)
    .text("Reported Cases of Abuse")
    .attr("transform", "rotate(-90)" )

svg.append("rect")
    .attr("x", 490)
    .attr("y", 27)
    .attr("height", 17)
    .attr("width", 40)
    .attr("fill", "white")
    .attr("stroke", "none")

svg.append("text")
    .attr('class', 'annotations')
    .attr("x", 497)
    .attr("y", 42)
    .text("148")
    .style("fill", "#C53630")
    .style("font-size", "15px")

svg.append("line")
    .attr("x1", 490) 
    .attr("y1", 48) 
    .attr("x2", 532) 
    .attr("y2", 48) 
    .attr("stroke", "#C53630")
    .attr("stroke-width", 2)

svg.append("rect") //Prieto governor highlight
    .attr("x", 424)
    .attr("y", 560)
    .attr("height", 80)
    .attr("width", 135)
    .attr("fill", '#C53630')
    .style("opacity", .2)

svg.append("text") // Prieto governor annotation ln 1
    .attr('class', 'annotations')
    .attr("x", 490)
    .attr("y", 525)
    .text("Prieto governor")
    .attr("text-anchor", "end")

svg.append("text") // Prieto governor annotation ln 2
    .attr('class', 'annotations')    
    .attr("x", 490)
    .attr("y", 540)
    .text("of Zulia")
    .attr("text-anchor", "end")

svg.append("text") // Prieto mayor annotation ln 1
    .attr('class', 'annotations')    
    .attr("x", 210)
    .attr("y", 598)
    .text("Prieto mayor")
    .attr("text-anchor", "start")

svg.append("text") // Prieto mayor annotation ln 2
    .attr('class', 'annotations')    
    .attr("x", 210)
    .attr("y", 613)
    .text("of San Francisco")
    .attr("text-anchor", "start")

svg.append("rect") //Prieto mayor highlight
    .attr("x", 109)
    .attr("y", 560)
    .attr("height", 80)
    .attr("width", 315)
    .attr("fill", '#374F98')
    .style("opacity", .2)

// hand-rolled legend
svg.append("rect")
    .attr("class", "plot-legend-rect")
    .attr("x", 10)
    .attr("y", 440)
    .attr("fill", '#374F98')

svg.append("rect")
    .attr("class", "plot-legend-rect")
    .attr("x", 300)
    .attr("y", 440)
    .attr("fill", '#C53630')

svg.append("text")
    .attr("class", 'plot-legend-text')
    .attr("x", 10)
    .attr("y", 440)
    .attr("dx", 30)
    .attr("dy", 15)
    .text("San Francisco Municipal Police")

svg.append("text")
    .attr("class", "plot-legend-text")
    .attr("x", 300)
    .attr("y", 440)
    .attr("dx", 30)
    .attr("dy", 15)
    .text("Zulia State Police")

// footer
svg.append("text") // source
    .attr('class', 'sources')
    .attr("x", -45)
    .attr("y", 690)
    .text("Source: PROVEA Annual Reports")

svg.append("text") // IC logo
    .attr('class', 'ic-logo')
    .attr("x", 560)
    .attr("y", 690)
    .html("i&hairsp;n&hairsp;s&hairsp;i&hairsp;g&hairsp;h&hairsp;t&hairsp;c&hairsp;r&hairsp;i&hairsp;m&hairsp;e&hairsp;.&hairsp;o&hairsp;r&hairsp;g")
})