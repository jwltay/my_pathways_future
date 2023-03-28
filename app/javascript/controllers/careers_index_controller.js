import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="careers-index"
export default class extends Controller {
  static targets = ["item", "graph"]

  connect() {
    fetch('graph.json')
      .then(res => res.json())
      .then(data => {
        this.graphData = data
        this.forceGraph = ForceGraph()
        this.loadGraph(this.graphData)
      })
  }

  expand(event) {
    this.itemTargets.forEach(item => item.classList.remove("active"))
    event.currentTarget.classList.add("active")
  }

  highlightNodes(e) {
    const nodeId = e.currentTarget.querySelector("h2").innerText
    const {nodes} = this.graphData
    const filtered = nodes.filter(node => node.id == nodeId)[0]

    this.forceGraph.zoom(5, 500).centerAt(filtered.x, filtered.y, 500)
  }

  expandNodeClick(node) {
    this.itemTargets.forEach(item => item.classList.remove("active"))
    this.itemTargets.forEach(
      item => {
        if (item.innerText.includes(node.id)) {
          item.classList.add("active")
          setTimeout(() => {
            item.scrollIntoView()
          }, 500)
        }
      })
  }

  loadGraph(data) {
    const width = this.element.clientWidth - 24
    this.forceGraph(this.graphTarget)
      .graphData(data)
      .nodeId('id')
      .nodeVal('val')
      .nodeLabel('id')
      .linkSource('source')
      .linkTarget('target')
      .linkDirectionalParticles(2)
      .linkWidth(2)
      .height(300)
      .width(width)
      .backgroundColor('rgb(77, 69, 93)')
      .nodeAutoColorBy('id')
      // .zoom(3, 1000)
      .enableZoomInteraction(false)
      .onNodeClick(node => { // Center/zoom on node
        this.forceGraph.centerAt(node.x, node.y, 1000)
        this.forceGraph.zoom(6, 500)
        this.expandNodeClick(node)
      })
      .onBackgroundClick(() => {
        this.forceGraph.zoom(2, 1000)
      })
  }
}
