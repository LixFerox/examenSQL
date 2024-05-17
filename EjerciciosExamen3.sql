/**********************/
/* CREACION DE TABLAS */
/**********************/
CREATE TABLE BandejaEntrada(
    fecha DATE,
    remitente VARCHAR(MAX),
    asunto VARCHAR(MAX),
    contenido VARCHAR(MAX),
    accion VARCHAR(MAX)

)
GO
CREATE TABLE movEntrada (
    id INT IDENTITY(1,1),
    vehiculo_id INT,
    fechaEntrada DATETIME,
    tipoCliente VARCHAR(50)
);
GO
CREATE TABLE movSalida (
    id INT IDENTITY(1,1),
    vehiculo_id INT,
    fechaSalida DATETIME,
    importe DECIMAL(10, 2)
);
GO
CREATE TABLE abonoClientes (
    id INT IDENTITY(1,1),
    vehiculo_id INT,
    fechaInicioAbono DATE,
    fechaFinAbono DATE,
    importeAbono DECIMAL(10, 2)
);

GO
/*****************/
/* POBLAR TABLAS */
/*****************/
INSERT INTO BandejaEntrada (fecha, remitente, asunto, contenido, accion)
VALUES
    ('2024-05-17', 'direccion@salesianosalcala.com', 'Reunión Importante', 'Recordatorio de la reunión importante de esta tarde.', ''),
    ('2024-05-16', 'usuario1@salesianosalcala.com', 'Solicitud de información', 'Hola, ¿puedes proporcionarme más información sobre el proyecto?', ''),
    ('2024-05-15', 'usuario2@empresa.com', 'Urgente: Actualización de presupuesto', 'Necesitamos una actualización del presupuesto para el proyecto.', ''),
    ('2024-05-14', 'usuario3@otraempresa.com', 'Recordatorio Reunión', 'Recordatorio de la reunión de equipo mañana por la mañana.', ''),
    ('2024-05-13', 'usuario4@salesianosalcala.com', 'Respuesta a tu pregunta', 'Aquí tienes la información que solicitaste.', ''),
    ('2024-05-12', 'usuario5@salesianosalcala.com', 'Prioritario: Reporte de ventas', 'Adjunto encontrarás el reporte de ventas actualizado.', ''),
    ('2024-05-11', 'usuario6@otradireccion.com', 'Solicitud de cotización', 'Necesitamos una cotización para el suministro de materiales.', ''),
    ('2024-05-10', 'usuario7@salesianosalcala.com', 'Información importante', 'Por favor, lee este mensaje, es importante para todos.', ''),
    ('2024-05-09', 'usuario8@empresa.com', 'Confirmación de reunión', 'Confirmo mi asistencia a la reunión programada para el próximo viernes.', ''),
    ('2024-05-08', 'usuario9@salesianosalcala.com', 'Urgente: Cambio de horario', 'La reunión ha sido adelantada dos horas. Por favor, confirma disponibilidad.', '');
GO
INSERT INTO movEntrada (vehiculo_id, fechaEntrada, tipoCliente) VALUES
(1, '2023-05-01 08:00:00', 'esporádico'),
(2, '2023-05-01 09:00:00', 'abonado'),
(3, '2023-05-01 10:30:00', 'esporádico'),
(4, '2023-05-02 11:00:00', 'abonado'),
(5, '2023-05-02 12:00:00', 'esporádico'),
(1, '2023-06-01 08:00:00', 'esporádico'),
(2, '2023-06-01 09:00:00', 'abonado'),
(3, '2023-06-01 10:30:00', 'esporádico'),
(4, '2023-06-02 11:00:00', 'abonado'),
(5, '2023-06-02 12:00:00', 'esporádico');
GO
INSERT INTO movSalida (vehiculo_id, fechaSalida, importe) VALUES
(1, '2023-05-01 08:30:00', 2.50),
(2, '2023-05-01 09:30:00', 0.00),
(3, '2023-05-01 11:00:00', 3.00),
(4, '2023-05-02 11:30:00', 0.00),
(5, '2023-05-02 12:30:00', 2.50),
(1, '2023-06-01 08:45:00', 2.50),
(2, '2023-06-01 09:45:00', 0.00),
(3, '2023-06-01 11:00:00', 3.00),
(4, '2023-06-02 11:30:00', 0.00),
(5, '2023-06-02 12:30:00', 2.50);
GO
INSERT INTO abonoClientes (vehiculo_id, fechaInicioAbono, fechaFinAbono, importeAbono) VALUES
(2, '2023-01-01', '2023-12-31', 100.00),
(4, '2023-01-01', '2023-12-31', 100.00);
GO
/***************/
/* EJERCICIO 1 */
/***************/
CREATE OR ALTER FUNCTION repeticiones(@c CHAR(1), @cad VARCHAR(500))
RETURNS INT
AS BEGIN
    DECLARE @retorno INT;
        IF(@cad)='' BEGIN
            SET @retorno=-1
        END
            ELSE BEGIN
                DECLARE @iterar INT=1;
                WHILE(@iterar<=LEN(@cad)) BEGIN
                    IF(SUBSTRING(UPPER(@cad),@iterar,1))=UPPER(@c) BEGIN
                        SET @retorno=1
                    END
                        ELSE BEGIN
                            SET @retorno=0
                        END
                    SET @iterar=@iterar+1
                END
            END
    RETURN @retorno
END
GO
SELECT dbo.repeticiones('z','HolA')
GO
/***************/
/* EJERCICIO 2 */
/***************/
CREATE OR ALTER FUNCTION repeticionesv2(@c CHAR(1), @cad VARCHAR(500), @caseSensitive BIT)
RETURNS INT
AS BEGIN
    DECLARE @retorno INT;
    IF(@caseSensitive)=0 BEGIN
        IF(@cad)='' BEGIN
            SET @retorno=-1
        END
            ELSE BEGIN
                DECLARE @iterar INT=1
                WHILE(@iterar<=LEN(@cad)) BEGIN
                    IF(SUBSTRING(UPPER(@cad), @iterar, 1))=UPPER(@c) BEGIN
                        SET @retorno=1
                    END
                        ELSE BEGIN
                            SET @retorno=0
                        END
                    SET @iterar=@iterar+1
                END
            END
    END
        ELSE IF(@caseSensitive)=1 BEGIN
            IF(@cad)='' BEGIN
                SET @retorno=-1
            END
                ELSE BEGIN
                    DECLARE @iterarTrue INT=1
                    WHILE(@iterarTrue<=LEN(@cad)) BEGIN
                        IF(SUBSTRING(@cad, @iterarTrue, 1))COLLATE Latin1_General_CI_AI =@c COLLATE Latin1_General_CI_AI BEGIN
                            SET @retorno=1
                        END
                            ELSE BEGIN
                                SET @retorno=0
                            END
                        SET @iterarTrue=@iterarTrue+1
                    END
                END
        END
        
    RETURN @retorno
END
GO
SELECT dbo.repeticionesv2('a', 'holá',1)
GO
/***************/
/* EJERCICIO 3 */
/***************/
CREATE OR ALTER PROCEDURE gestionarCorreo
AS BEGIN
    DECLARE @remitente VARCHAR(MAX)
    DECLARE @asunto VARCHAR(MAX)
    DECLARE cursorCorreo CURSOR FOR
    SELECT remitente, asunto
    FROM dbo.BandejaEntrada
    OPEN cursorCorreo
    FETCH NEXT FROM cursorCorreo INTO @remitente, @asunto
    WHILE @@FETCH_STATUS=0
    BEGIN
        IF(@remitente LIKE('direccion@salesianosalcala.com')) BEGIN
           UPDATE dbo.BandejaEntrada
           SET accion='Mover a Importante'
           WHERE remitente=@remitente
        END
            ELSE IF(UPPER(@asunto) IN('IMPORTANTE', 'URGENTE', 'PRIORITARIO')) BEGIN
                UPDATE dbo.BandejaEntrada
                SET accion='Mover a Importante'
                WHERE remitente=@remitente
            END
                ELSE IF(@remitente LIKE('%@salesianosalcala.com')) AND @remitente NOT LIKE('direccion@salesianosalcala.com') BEGIN
                    UPDATE dbo.BandejaEntrada
                    SET accion='Mover a correo Interno'
                    WHERE remitente=@remitente
                END
                    ELSE BEGIN
                        UPDATE dbo.BandejaEntrada
                        SET accion='Mover a la papelera'
                        WHERE remitente=@remitente
                    END

    FETCH NEXT FROM cursorCorreo INTO @remitente, @asunto
    END
    CLOSE cursorCorreo
    DEALLOCATE cursorCorreo
END
GO
EXEC gestionarCorreo
GO
/***************/
/* EJERCICIO 4 */
/***************/
DECLARE @totalMesMayor MONEY=0
DECLARE @totalMesMenor MONEY=0
SET @totalMesMayor=@totalMesMayor+(SELECT SUM(importe) FROM dbo.movSalida INNER JOIN dbo.movEntrada ON dbo.movEntrada.vehiculo_id=dbo.movSalida.vehiculo_id WHERE UPPER(tipoCliente)='ESPORÁDICO' AND CONVERT(INT,DATEDIFF(MINUTE,dbo.movSalida.fechaSalida,dbo.movEntrada.fechaEntrada))>60)
SET @totalMesMenor=@totalMesMenor+(SELECT SUM(importe/60)*60 FROM dbo.movSalida INNER JOIN dbo.movEntrada ON dbo.movEntrada.vehiculo_id=dbo.movSalida.vehiculo_id WHERE UPPER(tipoCliente)='ESPORÁDICO' AND CONVERT(INT,DATEDIFF(MINUTE,dbo.movSalida.fechaSalida,dbo.movEntrada.fechaEntrada))<60)
SELECT @totalMesMayor AS TotalMayor, @totalMesMenor AS TotalMenor
GO
DECLARE @totalMesEsporadico MONEY=0
DECLARE @totalMesAbonado MONEY=0
SET @totalMesEsporadico=@totalMesEsporadico+(SELECT SUM(importe) FROM dbo.movSalida INNER JOIN dbo.movEntrada ON dbo.movEntrada.vehiculo_id=dbo.movSalida.vehiculo_id WHERE UPPER(tipoCliente)='ESPORÁDICO')
SET @totalMesAbonado=@totalMesAbonado+(SELECT SUM(importe) FROM dbo.movSalida INNER JOIN dbo.movEntrada ON dbo.movEntrada.vehiculo_id=dbo.movSalida.vehiculo_id INNER JOIN dbo.abonoClientes ON dbo.movSalida.vehiculo_id=dbo.abonoClientes.vehiculo_id WHERE UPPER(tipoCliente)='ABONADO')
SET @totalMesAbonado=@totalMesAbonado+(SELECT SUM(importeAbono) FROM dbo.abonoClientes)
SELECT @totalMesEsporadico AS TotalEsporadico, @totalMesAbonado AS TotalAbonado
GO
/**************/
/* VER TABLAS */
/**************/
SELECT * FROM dbo.BandejaEntrada
SELECT * FROM dbo.movEntrada
SELECT * FROM dbo.movSalida
SELECT * FROM dbo.abonoClientes