const ctx_temperatura = document.getElementById("chartTemperatura");
const ctx_umidade = document.getElementById("chartUmidade");
const blueColor = "#36a2eb";
const redColor = "#ff6283";

new Chart(ctx_temperatura, {
  type: "line",
  data: {
    labels: ["12:00", "13:00", "14:00", "15:00", "16:00", "17:00"],
    datasets: [
      {
        label: "Temperatura",
        data: [30, 29, 28, 25, 22, 23],
        backgroundColor: redColor,
        borderColor: redColor,
        width: 1000
      },
    ],
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    scales: {
      y: {
        beginAtZero: true,
      },
    },
  },
});

new Chart(ctx_umidade, {
  type: "line",
  data: {
    labels: ["12:00", "13:00", "14:00", "15:00", "16:00", "17:00"],
    datasets: [
      {
        label: "Umidade",
        data: [80, 82, 80, 85, 80, 83],
        backgroundColor: blueColor,
        borderColor: blueColor,
      },
    ],
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    scales: {
      y: {
        beginAtZero: true,
      },
    },
  },
});
