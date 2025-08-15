---
title: Core App
description: Document containing all test cases/spec for the non-payment parts of the platform (Onboarding, Configuration, Demo, Processing)
---

## 1. Login e identidad

- [x] 1.1. El usuario solo puede iniciar sesión mediante Google OAuth.
- [x] 1.2. El inicio de sesión requiere consentimiento explícito para acceso a calendario y contactos.
- [x] 1.3. Si el login falla (Google no devuelve token válido), se muestra error claro y no se avanza.
- [x] 1.4. El token de acceso se almacena de forma segura y se renueva automáticamente antes de caducar.

## 2. Onboarding inicial

- [x] 2.1. Tras iniciar sesión por primera vez, el usuario debe responder un formulario con datos de su negocio (nombre, dirección, sector, etc.).
- [x] 2.2. El usuario puede seleccionar uno o varios calendarios de Google de entre los disponibles en su cuenta.
- [x] 2.3. El usuario debe elegir una plantilla de recordatorio (formal, neutra o informal).
- [x] 2.4. La interpolación de datos (nombre y localización del negocio) en la plantilla se realiza en tiempo de ejecución, al leer el evento del calendario y preparar el envío.
- [x] 2.5. El usuario debe aceptar Términos y Condiciones y Política de Privacidad.
- [x] 2.6. El usuario puede aceptar o rechazar el consentimiento para marketing.
- [x] 2.7. El usuario debe proporcionar un Sender ID (alfanumérico, máx. 11 caracteres) que se mostrará como remitente del SMS.

## 3. Envío de recordatorio demo

- [x] 3.1. Una vez completado el onboarding, el usuario puede enviar un único recordatorio demo.
- [x] 3.2. El recordatorio demo se envía al número de teléfono introducido por el propio usuario.
- [x] 3.3. El contenido del mensaje respeta la plantilla elegida.
- [x] 3.4. El recordatorio demo solo admite caracteres GSM 7-bit y no puede superar 3 mensajes concatenados (máx. 480 caracteres). En caso de superarlo, se truncara el mensaje.
- [x] 3.5. Tras enviar el demo, el usuario no puede acceder a más funcionalidades sin suscripción activa.

## 4. Gestión de configuración de usuario

- [x] 4.1. Un usuario autenticado puede modificar en cualquier momento:
  - Datos de negocio.
  - Calendario(s) integrado(s).
  - Plantilla de recordatorio.
  - Sender ID.
  - Preferencias de marketing.
- [x] 4.2. Los cambios de configuración se aplican a todos los envíos futuros.
- [x] 4.3. Si se pierde acceso al calendario por permisos revocados, el sistema no reconecta automáticamente; el caso se detecta por alertas internas y se gestiona manualmente. Si el usuario ha estado activo en los últimos 6 meses, este escenario no debería ocurrir.
- [x] 4.4. El sistema guarda un historial de cambios para auditoría basado en eventos. Logs de ejecucion tambien guardados de forma segura..

## 5. Panel de control

- [x] 5.1. El panel muestra: saldo de créditos, estado de suscripción, acceso a top-ups, historial de facturas y configuración.
- [x] 5.2. El usuario puede descargar cualquier factura desde el historial.
- [x] 5.3. El usuario puede enviar feedback desde un formulario integrado.

## 6. Envío de recordatorios reales

- [x] 6.1. Solo usuarios con suscripción activa o créditos de top-up pueden enviar mensajes.
- [x] 6.2. El contenido de cada recordatorio se genera a partir de la plantilla seleccionada y los datos del evento del calendario.
- [x] 6.3. Proceso de determinación de destinatarios y envío:
  - Al leer un evento del calendario, se comprueban los asistentes registrados en Google Calendar.
  - Para cada asistente, se consulta Google Contacts para intentar obtener un número de teléfono.
  - Si no se encuentra número en contactos, se intenta extraer posibles números de teléfono del título o la descripción del evento.
  - Se envía un SMS idéntico a cada número encontrado (uno por cada asistente identificado) exceptuando a el creador del evento.
- [x] 6.4. Si no hay créditos suficientes:
  - Si la falta de créditos se detecta antes de iniciar el envío, no se programa el recordatorio.
  - Si la falta de créditos se detecta durante el envío (“mid-flight”), se envía email notificando saldo insuficiente.
- [x] 6.5. Los créditos se descuentan inmediatamente antes del envío.
  - Si el mensaje falla tras deducir créditos, se devuelve el importe correspondiente.
  - Si el mensaje ocupa más partes SMS de las previstas, se ajustan los créditos después del envío.
  - Si tras el envío el número de créditos ha cruzado el umbral de 25, se envía un email notificando saldo bajo.
  - Todas las deducciones/ajustes se registran en el audit trail.
- [x] 6.6. El coste del SMS depende del país de destino (tarifa cargada desde la tabla de precios).

## 7. Restricciones y bordes

- [x] 7.1. Solo se envian recordatorios por SMS a números espanoles.
