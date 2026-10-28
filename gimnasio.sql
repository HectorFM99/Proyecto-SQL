--Ejercicio B1

--B1.2
CREATE TABLE planes (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    precio_mensual NUMERIC(6,2) NOT NULL CHECK (precio_mensual >= 0)
);

--B1.3
CREATE TABLE socios (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dni VARCHAR(9) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    fecha_alta DATE NOT NULL,
    plan_id INTEGER NOT NULL REFERENCES planes(id)
);

--B1.4
CREATE TABLE tarjetas (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    activa BOOLEAN NOT NULL,
    socio_id INTEGER UNIQUE NOT NULL REFERENCES socios(id)
);

--B1.5
CREATE TABLE monitores (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dni VARCHAR(9) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    especialidad VARCHAR(50)
);

--B1.6
CREATE TABLE clases (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    sala VARCHAR(50) NOT NULL,
    plazas INTEGER NOT NULL CHECK (plazas > 0),
    monitor_id INTEGER NOT NULL REFERENCES monitores(id)
);

--B1.7
CREATE TABLE reservas (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    socio_id INTEGER NOT NULL REFERENCES socios(id),
    clase_id INTEGER NOT NULL REFERENCES clases(id),
    fecha_reserva DATE NOT NULL,
    UNIQUE (socio_id, clase_id)
);

--B1.8
CREATE TABLE especialidades (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT
);

--B1.9
CREATE TABLE monitor_especialidades (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    monitor_id INTEGER NOT NULL REFERENCES monitores(id),
    especialidad_id INTEGER NOT NULL REFERENCES especialidades(id),
    CONSTRAINT uk_monitor_especialidad UNIQUE (monitor_id, especialidad_id)
);

--\dt y \d clases en psql, o Tables → Refresh en pgAdmin.

--Ejercicio B2

--B2.1
INSERT INTO planes (nombre, precio_mensual)
VALUES
    ('Básico', 29.90),
    ('Completo', 44.90),
    ('Estudiante', 24.90),
    ('Mañanas', 19.90);

--B2.2
INSERT INTO socios (dni, nombre, email, fecha_alta, plan_id)
VALUES
    ('11111111A', 'Ana Pérez', 'ana@gym.com', '2026-01-10', 2),
    ('22222222B', 'Luis García', 'luis@gym.com', '2026-02-03', 1),
    ('33333333C', 'Marta López', 'marta@gym.com', '2026-03-15', 3),
    ('44444444D', 'Hugo Sanz', 'hugo@gym.com', '2026-03-20', 2),
    ('55555555E', 'Lucía Ruiz', 'lucia@gym.com', '2026-05-02', 3),
    ('66666666F', 'Pablo Martín', 'pablo@gym.com', '2026-06-11', 1),
    ('77777777G', 'Sara Gil', 'sara@gym.com', '2026-09-01', 2),
    ('88888888H', 'Diego Vidal', 'diego@gym.com', '2026-10-01', 1);

--B2.3
INSERT INTO tarjetas (codigo, activa, socio_id)
VALUES
    ('TJ-0001', TRUE, 1),
    ('TJ-0002', TRUE, 2),
    ('TJ-0003', TRUE, 3),
    ('TJ-0004', FALSE, 4),
    ('TJ-0005', TRUE, 5),
    ('TJ-0006', TRUE, 6),
    ('TJ-0007', TRUE, 7);

--B2.4
INSERT INTO monitores (dni, nombre, email)
VALUES
    ('90000001J', 'Carla Navarro', 'carla@gym.com'),
    ('90000002K', 'Javier Ortega', 'javier@gym.com'),
    ('90000003L', 'Elena Romero', 'elena@gym.com'),
    ('90000004M', 'Rubén Castro', 'ruben@gym.com');

--B2.5
INSERT INTO clases (nombre, sala, fecha_hora, plazas, monitor_id)
VALUES
    ('Spinning', 'Sala 1', '2026-11-02 09:00', 12, 1),
    ('Yoga', 'Sala 2', '2026-11-02 18:00', 10, 2),
    ('Pilates', 'Sala 2', '2026-11-03 10:00', 8, 3),
    ('Spinning', 'Sala 1', '2026-11-03 19:00', 12, 1),
    ('Zumba', 'Sala 3', '2026-11-04 18:30', 20, 3),
    ('Yoga', 'Sala 2', '2026-11-05 09:30', 10, 2),
    ('Crossfit', 'Sala 3', '2026-11-05 20:00', 3, 1);

--B2.6
INSERT INTO reservas (socio_id, clase_id, fecha_reserva)
VALUES
    (1, 1, '2026-10-28'),
    (1, 3, '2026-10-28'),
    (1, 7, '2026-10-29'),
    (2, 1, '2026-10-29'),
    (2, 2, '2026-10-29'),
    (3, 2, '2026-10-30'),
    (3, 5, '2026-10-30'),
    (4, 1, '2026-10-30'),
    (4, 7, '2026-10-31'),
    (5, 3, '2026-10-31'),
    (5, 5, '2026-10-31'),
    (6, 4, '2026-11-01'),
    (7, 5, '2026-11-01'),
    (7, 7, '2026-11-01');

--B2.7
INSERT INTO especialidades (nombre)
VALUES
    ('Ciclo indoor'),
    ('Yoga'),
    ('Pilates'),
    ('Baile'),
    ('Fuerza');

--B2.8
INSERT INTO monitor_especialidades (monitor_id, especialidad_id)
VALUES
    (1, 1),
    (1, 5),
    (2, 2),
    (2, 3),
    (3, 3),
    (3, 4),
    (4, 5);

--Ejercicio B3

-- B3.1
INSERT INTO socios (dni, nombre, email, fecha_alta, plan_id)
VALUES ('99999999Z', 'Nora Prueba', 'nora@gym.com', '2026-10-27', 99);

-- B3.2
INSERT INTO socios (dni, nombre, email, fecha_alta, plan_id)
VALUES ('99999999Z', 'Nora Prueba', 'ana@gym.com', '2026-10-27', 1);

-- B3.3
INSERT INTO tarjetas (codigo, activa, socio_id)
VALUES ('TJ-0099', TRUE, 1);

-- B3.4
INSERT INTO reservas (socio_id, clase_id, fecha_reserva)
VALUES (1, 1, '2026-10-30');

-- B3.5
INSERT INTO reservas (socio_id, clase_id, fecha_reserva)
VALUES (2, 50, '2026-10-30');

-- B3.6
DELETE FROM planes WHERE nombre = 'Básico';

-- B3.7
DELETE FROM planes WHERE nombre = 'Mañanas';

--Ejercicio B4

--B4.1
SELECT s.nombre, p.nombre AS plan, p.precio_mensual
FROM socios AS s
JOIN planes AS p ON s.plan_id = p.id
ORDER BY s.nombre;

--B4.2
SELECT c.nombre AS actividad, c.fecha_hora, c.sala, m.nombre AS monitor
FROM clases AS c
JOIN monitores AS m ON c.monitor_id = m.id
ORDER BY c.fecha_hora;

--B4.3
SELECT s.nombre, t.codigo
FROM socios AS s
LEFT JOIN tarjetas AS t ON t.socio_id = s.id;

--B4.4
SELECT s.nombre
FROM socios AS s
LEFT JOIN tarjetas AS t ON t.socio_id = s.id
WHERE t.id IS NULL;

--B4.5
SELECT p.nombre AS plan, COUNT(s.id) AS cantidad_socios
FROM planes AS p
LEFT JOIN socios AS s ON s.plan_id = p.id
GROUP BY p.id, p.nombre
ORDER BY p.nombre;

--B4.6
SELECT s.nombre AS socio, c.nombre AS actividad, c.fecha_hora
FROM reservas AS r
JOIN socios AS s ON r.socio_id = s.id
JOIN clases AS c ON r.clase_id = c.id;

--B4.7
SELECT s.nombre
FROM reservas AS r
JOIN socios AS s ON r.socio_id = s.id
WHERE r.clase_id = 1;

--B4.8
SELECT c.nombre AS actividad, c.fecha_hora, c.plazas, COUNT(r.id) AS numero_reservas
FROM clases AS c
LEFT JOIN reservas AS r ON r.clase_id = c.id
GROUP BY c.id, c.nombre, c.fecha_hora, c.plazas
ORDER BY c.fecha_hora;

--B4.9
SELECT m.nombre
FROM monitores AS m
LEFT JOIN clases AS c ON c.monitor_id = m.id
WHERE c.id IS NULL;

--B4.10
SELECT m.nombre AS monitor, e.nombre AS especialidad
FROM monitores AS m
JOIN monitor_especialidades AS me ON me.monitor_id = m.id
JOIN especialidades AS e ON e.id = me.especialidad_id
ORDER BY m.nombre, e.nombre;

--Ejercicios B5

--B5.1
UPDATE socios
SET plan_id = (
    SELECT id
    FROM planes
    WHERE nombre = 'Completo'
)
WHERE email = 'luis@gym.com';

--B5.2
UPDATE tarjetas
SET activa = TRUE
WHERE codigo = 'TJ-0004';

--B5.3
INSERT INTO tarjetas (codigo, activa, socio_id)
SELECT 'TJ-0008', TRUE, id
FROM socios
WHERE email = 'diego@gym.com';

--B5.4
INSERT INTO reservas (socio_id, clase_id, fecha_reserva)
SELECT id, 6, '2026-11-02'
FROM socios
WHERE email = 'diego@gym.com';

--B5.5
DELETE FROM reservas
WHERE socio_id = (SELECT id FROM socios WHERE email = 'luis@gym.com')
  AND clase_id = 2;

--B5.6
DELETE FROM socios
WHERE email = 'pablo@gym.com';

--B5.7
DELETE FROM reservas
WHERE socio_id = (SELECT id FROM socios WHERE email = 'pablo@gym.com');

--B5.8
DELETE FROM socios
WHERE email = 'pablo@gym.com';