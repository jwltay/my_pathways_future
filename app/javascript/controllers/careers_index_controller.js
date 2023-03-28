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
    event.currentTarget.classList.toggle("inactive")
  }



  highlightNodes(e) {
    const nodeId = e.currentTarget.querySelector("h2").innerText
    const {nodes} = this.graphData
    const filtered = nodes.filter(node => node.id == nodeId)[0]

    this.forceGraph.zoom(6, 800).centerAt(filtered.x, filtered.y, 800)
  }

  // exitZoom() {
  //   this.forceGraph.zoom(2, 500).centerAt()
  // }

  expandNodeClick(node) {
    this.itemTargets.forEach(item => item.classList.remove("active"))
    this.itemTargets.forEach(
      item => {
        if (item.innerText.includes(node.id)) {
          item.classList.remove("inactive")
          setTimeout(() => {
            item.scrollIntoView()
          }, 500)
        }
      })
  }

  loadGraph(data) {
    const width = 480 //this.element.clientWidth - 24
    this.forceGraph(this.graphTarget)
      .graphData(data)
      .nodeId('id')
      .nodeVal('val')
      .nodeLabel('id')
      .linkSource('source')
      .linkTarget('target')
      .linkWidth(2)
      .height(400)
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
      .linkCanvasObjectMode(() => 'after')
      .linkCanvasObject((link, ctx) => {
        const MAX_FONT_SIZE = 4;
        const LABEL_NODE_MARGIN = this.forceGraph.nodeRelSize() * 1.5;

        const start = link.source;
        const end = link.target;

        // // ignore unbound links
        if (typeof start !== 'object' || typeof end !== 'object') return;

        // calculate label positioning
        const textPos = Object.assign(...['x', 'y'].map(c => ({
          [c]: start[c] + (end[c] - start[c]) / 2 // calc middle point
        })));

        const relLink = { x: end.x - start.x, y: end.y - start.y };

        const maxTextLength = Math.sqrt(Math.pow(relLink.x, 2) + Math.pow(relLink.y, 2)) - LABEL_NODE_MARGIN * 2;

        let textAngle = Math.atan2(relLink.y, relLink.x);
        // maintain label vertical orientation for legibility
        if (textAngle > Math.PI / 2) textAngle = -(Math.PI - textAngle);
        if (textAngle < -Math.PI / 2) textAngle = -(-Math.PI - textAngle);

        const label = `${link.target.id}`;

        // estimate fontSize to fit in link length
        ctx.font = '1px Sans-Serif';
        const fontSize = Math.min(MAX_FONT_SIZE, maxTextLength / ctx.measureText(label).width);
        ctx.font = `${fontSize}px Sans-Serif`;
        const textWidth = ctx.measureText(label).width;
        const bckgDimensions = [textWidth, fontSize].map(n => n + fontSize * 0.2); // some padding

        // draw text label (with background rect)
        ctx.save();
        ctx.translate(textPos.x, textPos.y);
        ctx.rotate(textAngle);

        ctx.fillStyle = 'rgb(77, 69, 93)';
        ctx.fillRect(- bckgDimensions[0] / 2, - bckgDimensions[1] / 2, ...bckgDimensions);

        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillStyle = 'darkgrey';
        ctx.fillText(label, 0, 0);
        ctx.restore();
      });
  }
}
