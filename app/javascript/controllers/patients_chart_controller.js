import { Controller } from "@hotwired/stimulus";
import ApexCharts from "apexcharts";

export default class extends Controller {
  static targets = ["chart"];

  static values = {
    categories: Array,
    series: Array,
  };

  connect() {
    window.ApexCharts = ApexCharts;
    this.chart = new ApexCharts(this.chartTarget, this.chartOptions);
    this.chart.render();
  }

  get chartOptions() {
    return {
      chart: {
        height: "350%",
        width: "200%",
        type: "bar",
      },
      series: [
        {
          name: "Patients",
          data: this.seriesValue,
        },
      ],
      xaxis: {
        categories: this.categoriesValue.map((date) => date.slice(0, 4)),
        title: {
          text: "Year of Birth",
          style: {
            fontSize: "16px",
          },
        },
      },
      yaxis: {
        title: {
          text: "Number of Patients",
          style: {
            fontSize: "16px",
          },
        },
      },
      plotOptions: {
        bar: {
          columnWidth: "99%",

          borderRadius: 5,
          dataLabels: {
            position: "top",
          },
        },
      },
    };
  }
}
