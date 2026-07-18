/* ============================================================
   BASE DE DATOS - PROYECTO DESERCIÓN ESTUDIANTIL PUCP
   Grupo 1 - Diplomado Data Visualization con Power BI
   Servidor: pucpserver.database.windows.net
   Base de datos: pucp
   Esquema: G1
   ============================================================
   
   INSTRUCCIONES:
   1. Conectarse a la base de datos "pucp" en SSMS
   2. Asegurarse que el desplegable diga "pucp"
   3. Ejecutar cada paso en orden (PASO 1 → PASO 2 → PASO 3)
   ============================================================ */


/* ------------------------------------------------------------
   PASO 1 — CREAR LAS 14 TABLAS
   Se crean primero las tablas de dimensión (catálogos),
   luego las tablas transaccionales (hechos).
   Tipos de dato correctos: INT para IDs, DATE para fechas,
   FLOAT para montos monetarios.
   ------------------------------------------------------------ */

-- DIMENSIONES (no dependen de otras tablas)

CREATE TABLE G1.FACULTAD (
    facultad_id             INT NOT NULL,
    nombre                  NVARCHAR(200),
    codigo                  NVARCHAR(10)
);

CREATE TABLE G1.BECA_ACADEMICA (
    beca_academica_id       INT NOT NULL,
    descripcion             NVARCHAR(200),
    porcentaje_descuento    INT
);

CREATE TABLE G1.ESCALA_PAGO (
    escala_pago_id          INT NOT NULL,
    codigo_escala           NVARCHAR(10),
    valor_credito           FLOAT,
    derecho_matricula       FLOAT,
    nse_referencial         NVARCHAR(50),
    primera_boleta          FLOAT,
    boleta_2da_a_5ta        FLOAT,
    pension_semestral_20cred FLOAT,
    cuota_mensual_ref       FLOAT
);

CREATE TABLE G1.COLEGO_PROCEDENCIA (
    colegio_id              INT NOT NULL,
    nombre_colegio          NVARCHAR(200),
    tipo_colegio            NVARCHAR(100),
    clasificacion_genero    NVARCHAR(50),
    distrito                NVARCHAR(100),
    gestion                 NVARCHAR(50)
);

CREATE TABLE G1.MODALIDAD_INGRESO (
    modalidad_ingreso_id    INT NOT NULL,
    nombre_modalidad        NVARCHAR(200),
    descripcion             NVARCHAR(500),
    tipo_canal              NVARCHAR(100),
    tipo_acceso             NVARCHAR(50),
    requisito_principal     NVARCHAR(200),
    frecuencia_convocatoria NVARCHAR(100)
);

CREATE TABLE G1.UBIGEO (
    ubigeo_id               INT NOT NULL,
    codigo_ubigeo           NVARCHAR(20),
    distrito                NVARCHAR(100),
    departamento            NVARCHAR(100),
    provincia               NVARCHAR(100),
    region                  NVARCHAR(100),
    tipo_zona               NVARCHAR(50)
);

CREATE TABLE G1.SEMESTRE_ACADEMICO (
    semestre_id             INT NOT NULL,
    codigo_sem              NVARCHAR(10),
    codigo                  NVARCHAR(10),
    descripcion             NVARCHAR(200),
    año                     INT,
    periodo                 INT,
    matriculas_objetivo     INT
);

CREATE TABLE G1.MATRICULA_ESTADO (
    matricula_estado_id     INT NOT NULL,
    descripcion             NVARCHAR(100)
);

CREATE TABLE G1.CAUSA_DESERCION (
    causa_desercion_id      INT NOT NULL,
    descripcion             NVARCHAR(200),
    tipo                    NVARCHAR(50)
);

CREATE TABLE G1.CURSO (
    curso_id                INT NOT NULL,
    nombre                  NVARCHAR(200),
    ciclo                   INT,
    numero_creditos         INT
);

-- TABLAS TRANSACCIONALES (dependen de las dimensiones)

CREATE TABLE G1.ALUMNO (
    alumno_id               INT NOT NULL,
    nombre                  NVARCHAR(100),
    apellido                NVARCHAR(100),
    fecha_nacimiento        DATE,
    genero                  NVARCHAR(10),
    facultad_id             INT,
    escala_pago_id          INT,
    beca_academica_id       INT,
    colegio_id              INT,
    modalidad_ingreso_id    INT,
    ubigeo_id               INT,
    año_ingreso             INT,
    distrito                NVARCHAR(100),
    provincia               NVARCHAR(100),
    tipo_zona               NVARCHAR(50),
    nse                     NVARCHAR(10),
    tipo_colegio            NVARCHAR(100),
    modalidad_ingreso       NVARCHAR(200),
    situacion_laboral       NVARCHAR(100)
);

CREATE TABLE G1.MATRICULA (
    matricula_id                    INT NOT NULL,
    fecha_matricula                 DATE,
    alumno_id                       INT,
    semestre_id                     INT,
    matricula_estado_id             INT,
    beca_academica_id               INT,
    escala_pago_id                  INT,
    ciclo_actual                    INT,
    promedio_ponderado_acumulado    FLOAT,
    creditos_aprobados_acumulados   INT
);

CREATE TABLE G1.CURSOS_X_MATRICULA (
    curso_x_matricula_id    INT NOT NULL,
    matricula_id            INT,
    curso_id                INT,
    curso_matricula_fecha   DATE,
    estado                  NVARCHAR(50)
);

CREATE TABLE G1.DESERCION (
    desercion_id            INT NOT NULL,
    matricula_id            INT,
    causa_desercion_id      INT,
    causa_secundaria_id     INT,
    tipo_desercion          NVARCHAR(100),
    fecha_desercion         DATE,
    observaciones           NVARCHAR(500)
);
GO


/* ------------------------------------------------------------
   PASO 2 — CREAR LAS PRIMARY KEY (PK)
   Una por cada tabla. Identifica de forma única cada fila.
   ------------------------------------------------------------ */

ALTER TABLE G1.ALUMNO              ADD CONSTRAINT PK_ALUMNO              PRIMARY KEY (alumno_id);
ALTER TABLE G1.BECA_ACADEMICA      ADD CONSTRAINT PK_BECA_ACADEMICA      PRIMARY KEY (beca_academica_id);
ALTER TABLE G1.CAUSA_DESERCION     ADD CONSTRAINT PK_CAUSA_DESERCION     PRIMARY KEY (causa_desercion_id);
ALTER TABLE G1.COLEGO_PROCEDENCIA  ADD CONSTRAINT PK_COLEGO_PROCEDENCIA  PRIMARY KEY (colegio_id);
ALTER TABLE G1.CURSO               ADD CONSTRAINT PK_CURSO               PRIMARY KEY (curso_id);
ALTER TABLE G1.CURSOS_X_MATRICULA  ADD CONSTRAINT PK_CURSOS_X_MATRICULA  PRIMARY KEY (curso_x_matricula_id);
ALTER TABLE G1.DESERCION           ADD CONSTRAINT PK_DESERCION           PRIMARY KEY (desercion_id);
ALTER TABLE G1.ESCALA_PAGO         ADD CONSTRAINT PK_ESCALA_PAGO         PRIMARY KEY (escala_pago_id);
ALTER TABLE G1.FACULTAD            ADD CONSTRAINT PK_FACULTAD            PRIMARY KEY (facultad_id);
ALTER TABLE G1.MATRICULA           ADD CONSTRAINT PK_MATRICULA           PRIMARY KEY (matricula_id);
ALTER TABLE G1.MATRICULA_ESTADO    ADD CONSTRAINT PK_MATRICULA_ESTADO    PRIMARY KEY (matricula_estado_id);
ALTER TABLE G1.MODALIDAD_INGRESO   ADD CONSTRAINT PK_MODALIDAD_INGRESO   PRIMARY KEY (modalidad_ingreso_id);
ALTER TABLE G1.SEMESTRE_ACADEMICO  ADD CONSTRAINT PK_SEMESTRE_ACADEMICO  PRIMARY KEY (semestre_id);
ALTER TABLE G1.UBIGEO              ADD CONSTRAINT PK_UBIGEO              PRIMARY KEY (ubigeo_id);
GO


/* ------------------------------------------------------------
   PASO 3 — CREAR LAS FOREIGN KEY (FK)
   16 relaciones que conectan las tablas entre sí.
   Orden: primero las FK de ALUMNO, luego MATRICULA,
   luego CURSOS_X_MATRICULA, finalmente DESERCION.
   ------------------------------------------------------------ */

-- ALUMNO → 6 dimensiones
ALTER TABLE G1.ALUMNO ADD CONSTRAINT FK_ALUMNO_FACULTAD
    FOREIGN KEY (facultad_id)         REFERENCES G1.FACULTAD(facultad_id);

ALTER TABLE G1.ALUMNO ADD CONSTRAINT FK_ALUMNO_ESCALA_PAGO
    FOREIGN KEY (escala_pago_id)      REFERENCES G1.ESCALA_PAGO(escala_pago_id);

ALTER TABLE G1.ALUMNO ADD CONSTRAINT FK_ALUMNO_BECA
    FOREIGN KEY (beca_academica_id)   REFERENCES G1.BECA_ACADEMICA(beca_academica_id);

ALTER TABLE G1.ALUMNO ADD CONSTRAINT FK_ALUMNO_COLEGIO
    FOREIGN KEY (colegio_id)          REFERENCES G1.COLEGO_PROCEDENCIA(colegio_id);

ALTER TABLE G1.ALUMNO ADD CONSTRAINT FK_ALUMNO_MODALIDAD
    FOREIGN KEY (modalidad_ingreso_id) REFERENCES G1.MODALIDAD_INGRESO(modalidad_ingreso_id);

ALTER TABLE G1.ALUMNO ADD CONSTRAINT FK_ALUMNO_UBIGEO
    FOREIGN KEY (ubigeo_id)           REFERENCES G1.UBIGEO(ubigeo_id);

-- MATRICULA → ALUMNO y 4 dimensiones
ALTER TABLE G1.MATRICULA ADD CONSTRAINT FK_MATRICULA_ALUMNO
    FOREIGN KEY (alumno_id)           REFERENCES G1.ALUMNO(alumno_id);

ALTER TABLE G1.MATRICULA ADD CONSTRAINT FK_MATRICULA_SEMESTRE
    FOREIGN KEY (semestre_id)         REFERENCES G1.SEMESTRE_ACADEMICO(semestre_id);

ALTER TABLE G1.MATRICULA ADD CONSTRAINT FK_MATRICULA_ESTADO
    FOREIGN KEY (matricula_estado_id) REFERENCES G1.MATRICULA_ESTADO(matricula_estado_id);

ALTER TABLE G1.MATRICULA ADD CONSTRAINT FK_MATRICULA_BECA
    FOREIGN KEY (beca_academica_id)   REFERENCES G1.BECA_ACADEMICA(beca_academica_id);

ALTER TABLE G1.MATRICULA ADD CONSTRAINT FK_MATRICULA_ESCALA_PAGO
    FOREIGN KEY (escala_pago_id)      REFERENCES G1.ESCALA_PAGO(escala_pago_id);

-- CURSOS_X_MATRICULA → MATRICULA y CURSO
ALTER TABLE G1.CURSOS_X_MATRICULA ADD CONSTRAINT FK_CXM_MATRICULA
    FOREIGN KEY (matricula_id)        REFERENCES G1.MATRICULA(matricula_id);

ALTER TABLE G1.CURSOS_X_MATRICULA ADD CONSTRAINT FK_CXM_CURSO
    FOREIGN KEY (curso_id)            REFERENCES G1.CURSO(curso_id);

-- DESERCION → MATRICULA y CAUSA_DESERCION (causa principal + causa secundaria)
ALTER TABLE G1.DESERCION ADD CONSTRAINT FK_DESERCION_MATRICULA
    FOREIGN KEY (matricula_id)        REFERENCES G1.MATRICULA(matricula_id);

ALTER TABLE G1.DESERCION ADD CONSTRAINT FK_DESERCION_CAUSA
    FOREIGN KEY (causa_desercion_id)  REFERENCES G1.CAUSA_DESERCION(causa_desercion_id);

ALTER TABLE G1.DESERCION ADD CONSTRAINT FK_DESERCION_CAUSA_SEC
    FOREIGN KEY (causa_secundaria_id) REFERENCES G1.CAUSA_DESERCION(causa_desercion_id);
GO


/* ------------------------------------------------------------
   PASO 4 — VERIFICACIÓN FINAL
   Confirma que las 14 tablas y 16 FK quedaron creadas.
   ------------------------------------------------------------ */

-- Verificar conteo de tablas en el esquema G1
SELECT TABLE_NAME, TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'G1'
ORDER BY TABLE_NAME;

-- Verificar las 16 relaciones FK creadas
SELECT 
    fk.name                 AS NombreFK,
    tp.name                 AS TablaOrigen,
    cp.name                 AS ColumnaOrigen,
    tr.name                 AS TablaReferenciada,
    cr.name                 AS ColumnaReferenciada
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables  tp ON fkc.parent_object_id     = tp.object_id
JOIN sys.columns cp ON fkc.parent_object_id     = cp.object_id AND fkc.parent_column_id    = cp.column_id
JOIN sys.tables  tr ON fkc.referenced_object_id = tr.object_id
JOIN sys.columns cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
WHERE SCHEMA_NAME(tp.schema_id) = 'G1'
ORDER BY tp.name;
