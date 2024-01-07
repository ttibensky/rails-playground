import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String };

  initialize() {
    this.charts = {};
  }

  async connect() {
    const data = await this.load();
    this.renderChart("month-chart", data.metrics.month);
    this.renderChart("year-chart", data.metrics.year);
    this.renderWordCloud(data["words"]);
  }

  async load() {
    const response = await fetch(this.urlValue);

    return response.json();
  }

  renderChart(target, metrics) {
    if (this.charts.hasOwnProperty(target)) {
      this.charts[target].destroy();
    }

    const htmlTarget = document.getElementById(target);
    this.charts[target] = new Chart(htmlTarget, {
      type: "bar",
      data: {
        labels: Object.keys(metrics),
        datasets: [
          {
            label: "# of Reviews",
            data: Object.values(metrics),
            borderWidth: 1,
          },
        ],
      },
      options: {
        responsive: false,
        scales: {
          y: {
            beginAtZero: true,
          },
        },
      },
    });
  }

  renderWordCloud(words) {
    WordCloud(document.getElementById("wordcloud"), {
      list: words,
      fontFamily: "",
      backgroundColor: "#ffe0e0",
      weightFactor: function (size) {
        return (Math.pow(size, 2.3) * 800) / 1024;
      },
    });
  }
}
