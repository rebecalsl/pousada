CREATE TABLE reservas (
    id SERIAL PRIMARY KEY,
    hospede_id INT REFERENCES hospedes(id),
    quarto_id INT REFERENCES quartos(id),
    data_checkin DATE,
    data_checkout DATE,
    status VARCHAR(50)
);