# Functional Acceptance Criteria – Subscription & Top-up System

## ✅ Crear suscripción

- [ ] Al crearla, la suscripción se activa inmediatamente
- [ ] Al crearla, se realiza el cobro inmediato del importe mensual del plan
- [ ] Si ya existe una suscripción activa, la creación se rechaza con error claro
- [ ] Si el usuario no tiene método de pago válido, la creación falla con mensaje específico
- [ ] Si el intento de cobro falla (tarjeta rechazada), la creación no se completa
- [ ] El período de validez se extiende desde la fecha actual hasta la misma fecha del mes siguiente
- [ ] Se emite un evento de auditoría o log para creación con `userId`, `planId` y `startDate`

## ✅ Cancelar suscripción

- [ ] Al cancelar una suscripción, no se cancela inmediatamente: sigue activa hasta el final del ciclo actual
- [ ] La cancelación se programa para que no haya renovación automática en el siguiente ciclo
- [ ] Si no hay ninguna suscripción activa, se rechaza la cancelación con error específico
- [ ] Un usuario puede cancelar aunque ya haya hecho un top-up adicional
- [ ] La fecha exacta de finalización es la misma del `startDate` + 1 mes
- [ ] Se notifica al usuario que mantendrá acceso hasta el final del ciclo
- [ ] No se realiza reembolso por los días restantes
- [ ] Si se vuelve a crear una suscripción antes de la fecha de finalización, se debe rechazar si ya hay una activa (aunque esté en cancelación pendiente)

## ✅ Reanudar suscripción

- [ ] Solo puede reanudarse una suscripción que está cancelada pero aún activa (antes de `endDate`)
- [ ] Reanudarla revierte la cancelación programada, manteniendo el mismo ciclo actual
- [ ] No se realiza un nuevo cobro al reanudar si ya se había cobrado el ciclo actual
- [ ] Si ya ha pasado la fecha de `endDate`, no puede reanudarse: se debe crear una nueva
- [ ] Si el usuario intenta reanudar sin tener una suscripción cancelada en curso, se muestra error claro

## ✅ Cambiar de plan – Upgrade (a un plan superior)

- [ ] El upgrade se aplica inmediatamente en el momento en que el usuario lo solicita
- [ ] Se realiza cobro inmediato del prorrateo correspondiente a la diferencia entre el nuevo plan y el actual, en función de los días restantes
- [ ] Se suman los créditos adicionales del nuevo plan de forma inmediata, proporcional al valor prorrateado pagado
- [ ] La fecha de renovación no cambia: sigue siendo la del final del ciclo original
- [ ] Si ya se había programado un downgrade, se debe cancelar automáticamente
- [ ] Si el cobro prorrateado falla, el upgrade se revierte y se notifica al usuario
- [ ] El sistema debe mostrar al usuario el importe que se le va a cobrar y los créditos que recibirá antes de confirmar

## ✅ Cambiar de plan – Downgrade (a un plan inferior)

- [ ] El downgrade no es inmediato: se programa para el final del ciclo actual
- [ ] No se cobra ni se devuelve nada en el momento del downgrade
- [ ] El sistema debe indicar al usuario la fecha exacta en la que el downgrade se hará efectivo
- [ ] El usuario sigue disfrutando del plan actual hasta el final del ciclo
- [ ] Al llegar el final del ciclo, el sistema no renueva el plan actual y crea automáticamente una suscripción al nuevo plan con cobro completo del nuevo importe
- [ ] Solo puede haber un downgrade programado a la vez; uno nuevo sobrescribe el anterior
- [ ] El usuario puede cancelar el downgrade programado antes de que entre en vigor
- [ ] Si el usuario hace un upgrade antes de la fecha efectiva del downgrade, el downgrade programado se cancela automáticamente
- [ ] El cambio no afecta a los créditos ya disponibles del plan superior actual

## ✅ Hacer top-up

- [ ] Se puede hacer top-up en cualquier momento, con o sin suscripción activa
- [ ] Al hacer un top-up, se cobra el importe correspondiente inmediatamente
- [ ] El crédito extra se suma al saldo del usuario, sin depender del estado de la suscripción
- [ ] Si no hay método de pago válido, se rechaza el top-up con mensaje claro
- [ ] El top-up no extiende ni modifica la duración de la suscripción activa
- [ ] Si el usuario solo tiene créditos de top-up, puede seguir enviando mensajes hasta agotarlos
- [ ] Se puede hacer top-up varias veces seguidas sin restricciones
- [ ] El saldo de créditos total debe reflejarse inmediatamente tras el top-up
- [ ] El recibo/factura debe reflejar el concepto “top-up” o “crédito adicional”

## ✅ Casos combinados y bordes

- [ ] Se puede cancelar una suscripción y luego hacer un top-up sin reactivarla
- [ ] Se puede programar un downgrade, cancelarlo, y volver a programar otro
- [ ] Se puede reanudar una suscripción cancelada y luego hacer un upgrade
- [ ] Se rechaza la creación de nueva suscripción si ya hay una activa o reanudada
- [ ] Se puede hacer top-up justo después de que termine la suscripción (sin reactivarla)
- [ ] Un usuario sin suscripción pero con créditos de top-up puede operar normalmente
- [ ] Si el usuario agota sus créditos y no tiene suscripción activa, no puede enviar más mensajes