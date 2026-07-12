const rooms = [
  { id: 101, name: "Quarto 101", description: "Padrao com cama de casal", capacity: 2, price: 150, status: "Disponivel" },
  { id: 102, name: "Quarto 102", description: "Deluxe com vista", capacity: 3, price: 250, status: "Ocupado" },
  { id: 201, name: "Suite 201", description: "Suite com sala e varanda", capacity: 4, price: 400, status: "Disponivel" }
];

const guests = [
  { id: 1, name: "Joao Silva", email: "joao@email.com", phone: "(11) 99999-9999", city: "Sao Paulo, SP", bookings: 2 },
  { id: 2, name: "Maria Santos", email: "maria@email.com", phone: "(11) 88888-8888", city: "Rio de Janeiro, RJ", bookings: 1 },
  { id: 3, name: "Pedro Oliveira", email: "pedro@email.com", phone: "(11) 77777-7777", city: "Belo Horizonte, MG", bookings: 3 }
];

const bookings = [
  { id: "#001", guest: "Joao Silva", room: "101", checkin: "2026-07-10", checkout: "2026-07-15", status: "Confirmada" },
  { id: "#002", guest: "Maria Santos", room: "102", checkin: "2026-07-20", checkout: "2026-07-25", status: "Pendente" },
  { id: "#003", guest: "Pedro Oliveira", room: "201", checkin: "2026-08-01", checkout: "2026-08-05", status: "Confirmada" }
];

const moneyFormatter = new Intl.NumberFormat("pt-BR", {
  style: "currency",
  currency: "BRL"
});

const dateFormatter = new Intl.DateTimeFormat("pt-BR", {
  day: "2-digit",
  month: "2-digit",
  year: "numeric"
});

function formatDate(date) {
  return dateFormatter.format(new Date(`${date}T12:00:00`));
}

function statusClass(status) {
  const normalized = status.toLowerCase();
  if (normalized.includes("dispon") || normalized.includes("confirm")) return "available confirmed";
  if (normalized.includes("pend") || normalized.includes("ocup")) return "occupied pending";
  return "cancelled";
}

function renderMetrics() {
  const availableRooms = rooms.filter((room) => room.status === "Disponivel").length;
  const activeBookings = bookings.filter((booking) => booking.status !== "Cancelada").length;
  const monthlyRevenue = bookings.reduce((total, booking) => {
    const room = rooms.find((item) => String(item.id) === booking.room);
    return total + (room?.price ?? 0);
  }, 0);

  const metrics = [
    ["Quartos disponiveis", availableRooms],
    ["Reservas ativas", activeBookings],
    ["Hospedes", guests.length],
    ["Receita estimada", moneyFormatter.format(monthlyRevenue)]
  ];

  document.querySelector("#metricsGrid").innerHTML = metrics
    .map(([label, value]) => `<article class="metric"><span>${label}</span><strong>${value}</strong></article>`)
    .join("");
}

function renderRooms() {
  document.querySelector("#roomsGrid").innerHTML = rooms
    .map((room) => `
      <article class="card">
        <div>
          <h3>${room.name}</h3>
          <p>${room.description}</p>
        </div>
        <p>Capacidade: ${room.capacity} pessoas</p>
        <div class="card-footer">
          <span class="price">${moneyFormatter.format(room.price)}/noite</span>
          <span class="badge ${statusClass(room.status)}">${room.status}</span>
        </div>
      </article>
    `)
    .join("");
}

function renderBookings() {
  const rows = bookings
    .map((booking) => `
      <tr>
        <td>${booking.id}</td>
        <td>${booking.guest}</td>
        <td>${booking.room}</td>
        <td>${formatDate(booking.checkin)} a ${formatDate(booking.checkout)}</td>
        <td><span class="badge ${statusClass(booking.status)}">${booking.status}</span></td>
      </tr>
    `)
    .join("");

  document.querySelector("#bookingRows").innerHTML = rows;
  document.querySelector("#upcomingBookings").innerHTML = bookings
    .slice(0, 3)
    .map((booking) => `
      <tr>
        <td>${booking.guest}</td>
        <td>${booking.room}</td>
        <td>${formatDate(booking.checkin)}</td>
        <td>${formatDate(booking.checkout)}</td>
        <td><span class="badge ${statusClass(booking.status)}">${booking.status}</span></td>
      </tr>
    `)
    .join("");
}

function renderGuests() {
  document.querySelector("#guestsGrid").innerHTML = guests
    .map((guest) => `
      <article class="card">
        <div>
          <h3>${guest.name}</h3>
          <p>${guest.city}</p>
        </div>
        <p>${guest.email}</p>
        <p>${guest.phone}</p>
        <div class="card-footer">
          <span>${guest.bookings} reservas</span>
          <span class="badge available">Ativo</span>
        </div>
      </article>
    `)
    .join("");
}

function setupTabs() {
  document.querySelectorAll(".tab").forEach((tab) => {
    tab.addEventListener("click", () => {
      document.querySelectorAll(".tab").forEach((item) => item.classList.remove("active"));
      document.querySelectorAll(".view").forEach((view) => view.classList.remove("active"));
      tab.classList.add("active");
      document.querySelector(`#${tab.dataset.view}`).classList.add("active");
    });
  });
}

function setupFeedback() {
  const dialog = document.querySelector("#feedbackDialog");
  const message = document.querySelector("#dialogMessage");
  const actions = {
    newRoomButton: "Cadastro de quarto preparado para integracao com backend.",
    newBookingButton: "Cadastro de reserva preparado para integracao com backend.",
    newGuestButton: "Cadastro de hospede preparado para integracao com backend."
  };

  Object.entries(actions).forEach(([id, text]) => {
    document.querySelector(`#${id}`).addEventListener("click", () => {
      message.textContent = text;
      dialog.showModal();
    });
  });
}

function updateConnectionStatus() {
  const status = document.querySelector("#connectionStatus");
  status.textContent = navigator.onLine ? "Online" : "Offline";
}

function registerServiceWorker() {
  if ("serviceWorker" in navigator) {
    navigator.serviceWorker.register("service-worker.js").catch(() => undefined);
  }
}

renderMetrics();
renderRooms();
renderBookings();
renderGuests();
setupTabs();
setupFeedback();
updateConnectionStatus();
registerServiceWorker();

window.addEventListener("online", updateConnectionStatus);
window.addEventListener("offline", updateConnectionStatus);
