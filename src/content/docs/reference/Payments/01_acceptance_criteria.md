# Functional Acceptance Criteria – Subscription & Top-up System

## 1. Crear suscripción
- [x] 1.1. Al crearla, la suscripción se activa inmediatamente

- [x] 1.2. Al crearla, se realiza el cobro inmediato del importe mensual del plan
Comment: the invoice says `paid` but the money apparently doesn't make it into the Stripe balance until 7 days later.

- [x] 1.3. Si ya existe una suscripción activa, la creación se rechaza con error claro

- [x] 1.4. Si el usuario no tiene método de pago válido, la creación falla con mensaje específico

- [x] 1.5. Si el intento de cobro falla (tarjeta rechazada), la creación no se completa

- [x] 1.6. El período de validez se extiende desde la fecha actual hasta la misma fecha del mes siguiente

- [x] 1.7. Se emite un evento de auditoría o log para creación con userId, planId y startDate

- [x] 1.8. Test payment with card from other country/coin (to check conversion).

## 2. Cancelar suscripción
- [x] 2.1. Al cancelar una suscripción, no se cancela inmediatamente: sigue activa hasta el final del ciclo actual

- [x] 2.2. La cancelación se programa para que no haya renovación automática en el siguiente ciclo

- [x] 2.3. Un usuario puede cancelar aunque ya haya hecho un top-up adicional

- [x] 2.4. Si no hay ninguna suscripción activa, se rechaza la cancelación con error específico. Stripe no muestra el botón de cancelar en ese caso.

- [x] 2.5. La fecha exacta de finalización es la misma del startDate + 1 mes

- [x] 2.6. Se notifica al usuario que mantendrá acceso hasta el final del ciclo

- [x] 2.7. No se realiza reembolso por los días restantes

- [x] 2.8. Si se vuelve a crear una suscripción antes de la fecha de finalización, se debe rechazar si ya hay una activa (aunque esté en cancelación pendiente)

- [x] 2.9. Si Notifycal Admins cancelan una subscripcion(desde Stripe dashboard), se debe de cancelar la subscripcion del usuario en la app tambien.

## 3. Reanudar suscripción
- [x] 3.1. Solo puede reanudarse una suscripción que está cancelada pero aún activa (antes de endDate)

- [x] 3.2. Reanudarla revierte la cancelación programada, manteniendo el mismo ciclo actual

- [x] 3.3. No se realiza un nuevo cobro al reanudar si ya se había cobrado el ciclo actual

- [x] 3.4. Si ya ha pasado la fecha de endDate, no puede reanudarse: se debe crear una nueva

- [x] 3.5. Si el usuario intenta reanudar sin tener una suscripción cancelada en curso, se muestra error claro. Stripe no muestra el boton de "reanudar".

## 4. Cambiar de plan – Upgrade (a un plan superior)
- [x] 4.1. El upgrade se aplica inmediatamente en el momento en que el usuario lo solicita

- [x] 4.2. Se realiza cobro inmediato del prorrateo correspondiente a la diferencia entre el nuevo plan y el actual, en función de los días restantes

- [x] 4.3. Se suman los créditos adicionales del nuevo plan de forma inmediata, proporcional al valor prorrateado pagado

- [x] 4.4. La fecha de renovación no cambia: sigue siendo la del final del ciclo original

- [x] 4.5. Si ya se había programado un downgrade, se debe cancelar automáticamente

- [x] 4.6. Si el cobro prorrateado falla, el upgrade se revierte y se notifica al usuario

- [x] 4.7. El sistema debe mostrar al usuario el importe que se le va a cobrar y los créditos que recibirá antes de confirmar

- [x] 4.8. Si ya se había programado una cancelacion, se debe cancelar (la cancelación) automáticamente

- [x] 4.9. Si la cancelacion es efectiva (ha acabado el ciclo de cobro) no se puede hacer upgrade.

- [x] 4.10. La actualización de créditos debe tener en cuenta los créditos que el usuario haya gastado ya. Por ejemplo, si el usuario esta en "better" (250 créditos), gasta 50 créditos, y hace un upgrade a "best" (1000 créditos), el resultado deberá ser 750.

- [x] 4.11. Un upgrade es posible incluso si el cliente es capaz de hacerlo en el primer segundo del nuevo ciclo de facturacion. 

## 5. Cambiar de plan – Downgrade (a un plan inferior)
- [x] 5.1. El downgrade no es inmediato: se programa para el final del ciclo actual

- [x] 5.2. No se cobra ni se devuelve nada en el momento del downgrade

- [x] 5.3. El sistema debe indicar al usuario la fecha exacta en la que el downgrade se hará efectivo

- [x] 5.4. El usuario sigue disfrutando del plan actual hasta el final del ciclo

- [x] 5.5. El cambio no afecta a los créditos ya disponibles del plan superior actual

- [x] 5.6. El usuario puede cancelar el downgrade programado antes de que entre en vigor. La UI de stripe puede ser un poco difusa, hay que entrar desde el Customer portal > Actualizar subscripción en vez de el propio boton de "Modificar subscripcion"

- [x] 5.7. Al llegar el final del ciclo, el sistema no renueva el plan actual y crea automáticamente una suscripción al nuevo plan con cobro completo del nuevo importe

- [ ] 5.8. [Stripe bug] Solo puede haber un downgrade programado a la vez; uno nuevo sobreescribe el anterior.


- [x] 5.9. Si el usuario hace un upgrade antes de la fecha efectiva del downgrade, el downgrade programado se cancela automáticamente. 

- [x] 5.10. Al hacer doble downgrade, y cancelarlo, vuelve al plan original, antes de ninguno de los downgrades.

- [x] 5.11. El usuario puede hacer downgrade después de cancelar su subscripción (scheduled) y se anula la cancelación.

- [x] 5.12. El usuario no puede hacer downgrade después de la cancelación efectiva de su subscripción. Stripe no deja hacer esto por diseño, porque la subscripcion ya no esta en estado "activo".


## 6. Hacer top-up

- [x] 6.2. Al hacer un top-up, se cobra el importe correspondiente inmediatamente

- [x] 6.3. El crédito extra se suma al saldo del usuario, sin depender del estado de la suscripción

- [x] 6.4. Si no hay método de pago válido, se rechaza el top-up con mensaje claro

- [x] 6.5. El top-up no extiende ni modifica la duración de la suscripción activa

- [x] 6.6. El saldo de créditos total debe reflejarse inmediatamente tras el top-up

- [x] 6.7. Se puede hacer top-up varias veces seguidas sin restricciones

- [x] 6.8. Se pueden comprar varios topups en la misma transaccion y lo creditos del usuario lo reflejan

- [x] 6.9. El recibo/factura debe reflejar el concepto “top-up” o “crédito adicional”.

- [x] 6.10. Si los creditos de subscripcion no son suficientes para mandar el mensaje, se usan los creditos de topup.

- [x] 6.11. Si el usuario solo tiene créditos de top-up, porque se le han agotado los creditos de subscripcion puede seguir enviando mensajes hasta agotarlos.

## 7. Casos combinados y bordes

- [x] 7.2. Se puede programar un downgrade, cancelarlo, y volver a programar otro

- [x] 7.3. Se puede reanudar una suscripción cancelada (scheduled) y luego hacer un upgrade

- [x] 7.4. No se puede reanudar una suscripción cancelada (non-scheduled) y (y por tanto tampoco) luego hacer un upgrade

- [x] 7.5. Se rechaza la creación de nueva suscripción si ya hay una activa o reanudada

- [x] 7.8. Si el usuario agota sus créditos y SI tiene suscripción activa, no puede enviar más mensajes

- [x] 7.9. Si el usuario agota sus creditos, y SI tiene subscripcion activa, debe recibir un email.

- [x] 7.10. Si el usuario cruza el umbral de "alerta por creditos bajos", recibe un email.

- [x] 7.11. Si el usuario agota sus créditos y NO tiene suscripción activa, no puede enviar más mensajes

- [x] 7.12. Para cumplir la ley, aun sin tener una subscripcion activa, se le debe dejar al usuario consultar sus facturas.

- [x] 7.13. La renovacion de una subscripcion se ejecuta inmediatamente cuando empieza el nuevo  ciclo de facturacion. Por defecto, Stripe espera una hora dentro del nuevo ciclo de facturacion.

## 8. Deductions
- [x] 8.1. Testear escenario out-of-credits. El usuario tiene creditos para mandar 1 solo mensaje (o incluso menos creditos). El user status debe cambiar a out-of-credits la siguiente vez que intente mandar un mensaje. Debido a esto, se puede estar a 0 creditos y no estar en out-of-credits todavia (no se ha intentado mandar otro mensaje).


---

## Sin implementar

### 6. Hacer top-up

> Los creditos de topup solo se pueden comprar si hay una subscripcion activa, es decir, para "acabar el mes".

- [ ] 6.1. Se puede hacer top-up en cualquier momento, con o sin suscripción activa. To be implemented. [Ticket](https://github.com/Notifycal/frontend/issues/450)

- [ ] 6.12. Si el usuario solo tiene créditos de top-up, porque no ha renovado la subscripción por problemas de pago puede seguir enviando mensajes hasta agotarlos. [Ticket](https://github.com/Notifycal/frontend/issues/450)

- [ ] 6.13.  Si el usuario solo tiene créditos de top-up, porque ha cancelado la subscripción, puede seguir enviando mensajes hasta agotarlos.  [Ticket](https://github.com/Notifycal/frontend/issues/450)

### 7. Casos combinados y bordes

- [ ] 7.1. Se puede cancelar una suscripción y luego hacer un top-up sin reactivarla

- [ ] 7.6. Se puede hacer top-up justo después de que termine la suscripción (sin reactivarla)

- [ ] 7.7. Un usuario sin suscripción pero con créditos de top-up puede operar normalmente

## Utils

Remember to clear the idempotency table when required:

```shell
delete_all_items() {
  table="$1"
  aws dynamodb scan --table-name "$table" --output json |
    jq -c '.Items[] | select(.RunId and .RunId.S) | .RunId.S' |
    while read -r runid; do
      runid_clean=$(echo "$runid" | tr -d '"')
      echo "Deleting $runid_clean"
      aws dynamodb delete-item \
        --table-name "$table" \
        --key "{\"RunId\": {\"S\": \"$runid_clean\"}}"
    done
}

delete_all_items LambdaIdempotency-dev
```

## Trigger background processing

Background processing puede ser ejecutado artificialmente, es decir, no por el schduled job segun el tiempo natural sino usando cualquier fecha y hora pasada o futura haciendo trigger de fetch-user-calendars lambda usando este JSON:
The field `Records[*].body.time` is the relevant one here. Esto te evita esperar 30 minutos al siguiente run. Actualiza Record[*].body.time como gustes.

```json
{
        "Records": [
            {
                "messageId": "5e62dd00-da98-4e91-a72d-70c2925c21d4",
                "receiptHandle": "AQEBuhRfwz53e1HI6CfBuyS+kI0KKMBdvZty2rmlYTXpq5m8Xt1p6pVo8MgdcCObCtp79OjF+TeNVOrzDOOm8wOuei1bRujNA7KauGbHNy63T5E046HjjXZKrCp5GYln8bx8qYQ4OOiCs5qlP1olXL8SveD3/I81DZkLHCPWFozq0Gihz9UWuf2s99kK2hTYWUqPd4JaAphal1TKJf0/Hfa5vlAFo8DEBV0To7b6UDTzYKY1TSqlvW+Kh1b0in71Q4BLH1G9aw/9W/qAuzLqfoojdUhowTAOgWDd/V6N1q4KtxA=",
                "body": "{\"version\":\"0\",\"id\":\"2b1b6467-fc0a-2791-2570-fabd802f4b1d\",\"detail-type\":\"Scheduled Event\",\"source\":\"aws.events\",\"account\":\"381492094204\",\"time\":\"2025-07-31T13:30:00Z\",\"region\":\"eu-west-1\",\"resources\":[\"arn:aws:events:eu-west-1:381492094204:rule/fetch-user-calendars-schedule-dev\"],\"detail\":{}}",
                "attributes": {
                    "ApproximateReceiveCount": "1",
                    "SentTimestamp": "1753965043109",
                    "SequenceNumber": "18895759124745455616",
                    "MessageGroupId": "event-bridge",
                    "SenderId": "AIDAJ2E4ZHTZPIG4AM4I6",
                    "MessageDeduplicationId": "78d7fce142a72a9776f6d6cd9b731299179c6358fe35849184596bce6166da0a",
                    "ApproximateFirstReceiveTimestamp": "1753965043109"
                },
                "messageAttributes": {},
                "md5OfBody": "16c9e713004bc44d941c61a70fdd325a",
                "eventSource": "aws:sqs",
                "eventSourceARN": "arn:aws:sqs:eu-west-1:381492094204:fetch-user-calendars-dev.fifo",
                "awsRegion": "eu-west-1"
            }
        ]
    }
```