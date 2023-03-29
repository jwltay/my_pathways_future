import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["popup", "details", "career"]

  connect() {
    this.detailsGraphData
  }

  showModal() {
    this.popupTarget.classList.add("show")
    window.addEventListener("keyup", this.keyDispatcher.bind(this))
    // console.log("connected to details graph");
    fetch('graph.json')
      .then(res => res.json())
      .then(data => {
        this.detailsGraphData = data
        this.detailsGraph = ForceGraph()
        this.loadDetailsGraph(this.detailsGraphData)

        setTimeout(() => {
          const nodeId = this.careerTarget.innerText
          const career = this.detailsGraphData.nodes.filter(node => node.id == nodeId)[0]
          this.detailsGraph.zoom(6, 800).centerAt(career.x, career.y, 800)
        }, 1200)
      })

  }

  hideModal() {
    this.popupTarget.classList.remove("show")
    window.removeEventListener("keyup", this.keyDispatcher)
  }

  keyDispatcher(e) {
    if (e.key == "Escape") {
      this.hideModal()
    }
  }

  loadDetailsGraph(data) {
    const width = 300 // this.element.clientWidth * 0.6
    const height = 250 //this.element.clientHeight
    // console.log(JSON.stringify(career));

    this.detailsGraph(this.detailsTarget)
      .graphData(data)
      .nodeId('id')
      .nodeVal('val')
      .nodeLabel('id')
      .linkSource('source')
      .linkTarget('target')
      .height(height)
      .width(width)
      .backgroundColor('#fffcf5')
      .nodeAutoColorBy('name')
      .linkColor(link => '#4d455d')
      .onBackgroundClick(() => {
        this.detailsGraph.zoom(2, 1000)
      })
      .nodeCanvasObject((node, ctx, globalScale) => {
        const label = node.id
        const fontSize = 12/globalScale
        ctx.font = `${fontSize}px Sans-Serif`
        const textWidth = ctx.measureText(label).width
        const bckgDimensions = [textWidth, fontSize].map(n => n + fontSize * 0.2) // some padding

        ctx.fillStyle = 'rgba(255, 255, 255, 0.8)'
        ctx.fillRect(node.x - bckgDimensions[0] / 2, node.y - bckgDimensions[1] / 2, ...bckgDimensions)

        ctx.textAlign = 'center'
        ctx.textBaseline = 'middle'
        ctx.fillStyle = node.color
        ctx.fillText(label, node.x, node.y)

        node.__bckgDimensions = bckgDimensions // to re-use in nodePointerAreaPaint
      })
      .nodePointerAreaPaint((node, color, ctx) => {
        ctx.fillStyle = color
        const bckgDimensions = node.__bckgDimensions
        bckgDimensions && ctx.fillRect(node.x - bckgDimensions[0] / 2, node.y - bckgDimensions[1] / 2, ...bckgDimensions)
      })
  }
}
