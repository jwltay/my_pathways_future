import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="careers-index"
export default class extends Controller {
  static targets = ["item"]

  connect() {
    console.log("connected to graph")
    this.loadGraph()
  }

  expand(event) {
    this.itemTargets.forEach(item => item.classList.remove("active"))
    event.currentTarget.classList.add("active");
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

  loadGraph() {
    const width = this.element.clientWidth - 24
    console.log(width)

    fetch('graph.json')
    .then(res => res.json())
    .then(data => {
      const Graph = ForceGraph()
      (document.getElementById('graph'))
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
      .enableZoomInteraction(false)
      .zoom(2, 1000)
      .onNodeClick(node => { // Center/zoom on node
        Graph.centerAt(node.x, node.y, 1000)
        Graph.zoom(6, 500)
        this.expandNodeClick(node)
      })
      .onBackgroundClick(() => {
        Graph.zoom(2, 1000)
      })
      .nodeCanvasObject((node, ctx, globalScale) => {
        const label = node.id;
        const fontSize = 18/globalScale;
        ctx.font = `${fontSize}px Sans-Serif`;
        const textWidth = ctx.measureText(label).width;
        const bckgDimensions = [textWidth, fontSize].map(n => n + fontSize * 0.4); // some padding

        ctx.fillStyle = 'rgba(255, 255, 255, 0)';
        ctx.fillRect(node.x - bckgDimensions[0] / 2, node.y - bckgDimensions[1] / 2, ...bckgDimensions);

        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillStyle = node.color;
        ctx.fillText(label, node.x, node.y);

        node.__bckgDimensions = bckgDimensions; // to re-use in nodePointerAreaPaint
      })
      .nodePointerAreaPaint((node, color, ctx) => {
        ctx.fillStyle = color;
        const bckgDimensions = node.__bckgDimensions;
        bckgDimensions && ctx.fillRect(node.x - bckgDimensions[0] / 2, node.y - bckgDimensions[1] / 2, ...bckgDimensions);
      })
    })
  }
}
