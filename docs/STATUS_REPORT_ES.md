# Informe de Estado del Proyecto - AlkimiaTech

**Fecha:** 1 de julio de 2026  
**Versión:** MVP 1.0  
**Estado:** Funcional y validado

---

## Visión General

AlkimiaTech es una plataforma de inteligencia predictiva para epilepsia, basada en IA y wearables, que utiliza biomarcadores fisiológicos (frecuencia cardíaca, oxígeno en sangre, movimiento) para predecir el riesgo de crisis en tiempo real.

---

## Avances Técnicos

| Componente          | Estado         | Descripción                                              |
| ------------------- | -------------- | -------------------------------------------------------- |
| **App Flutter**     | ✅ Funcional   | Interfaz de usuario con simulación Bluetooth (HR, SpO2). |
| **Backend FastAPI** | ✅ Funcional   | API REST con validaciones y predicción de riesgo.        |
| **Bluetooth Real**  | ✅ Funcional   | Conexión con Amazfit Bip 6 (detectado desde Kali).       |
| **Seguridad API**   | ✅ Validada    | Pruebas con Kali Linux: validaciones, errores, límites.  |
| **Landing Page**    | ✅ Publicada   | `https://alexmop.github.io/alkimiatech-mvp/`             |
| **LinkedIn**        | ✅ Actualizado | Perfil profesional con enlace a landing page.            |

---

## Pruebas de Seguridad Realizadas

| Prueba                        | Herramienta | Resultado                               |
| ----------------------------- | ----------- | --------------------------------------- |
| Escaneo de puertos            | Nmap        | Puerto 8080 abierto                     |
| Prueba de API (GET)           | curl        | `200 OK`                                |
| Prueba de API (POST válido)   | curl        | Predicción correcta                     |
| Prueba de API (POST inválido) | curl        | `422 Unprocessable Entity`              |
| Validación de límites         | curl        | Rechazo de valores fuera de rango       |
| Escaneo Bluetooth             | hcitool     | Dispositivo detectado (`Amazfit Bip 6`) |

---

## Métricas Clave

| Métrica                        | Valor                                   |
| ------------------------------ | --------------------------------------- |
| **Tiempo de respuesta API**    | < 100 ms                                |
| **Validaciones implementadas** | 4 campos (HR, SpO2, movimiento, estrés) |
| **Código fuente**              | 100% en inglés                          |
| **Landing page**               | Publicada y accesible                   |

---

## Próximos Pasos

| Tarea                             | Prioridad | Estado    |
| --------------------------------- | --------- | --------- |
| Enviar emails a startups          | 🔴 MÁXIMA | Pendiente |
| Conectar Bluetooth real desde app | 🟡 ALTA   | Pendiente |
| Mejorar landing page              | 🟡 ALTA   | Pendiente |
| Pruebas de usabilidad             | 🟢 MEDIA  | Pendiente |

---

## Enlaces Importantes

| Recurso               | URL                                                |
| --------------------- | -------------------------------------------------- |
| Landing Page          | `https://alexmop.github.io/alkimiatech-mvp/`       |
| Repositorio (App)     | `https://github.com/Alexmop/alkimiatech-mvp`       |
| Repositorio (Backend) | `https://github.com/Alexmop/smartwatch_backend`    |
| LinkedIn              | `https://linkedin.com/company/alkimiatech-startup` |
| Correo                | `hello@alkimiatech.dev`                            |

---

## Notas

- Todo el código está documentado en inglés.
- La API incluye validaciones de seguridad (límites en HR, SpO2, etc.).
- Las pruebas de Kali Linux confirmaron que la API es segura y robusta.
- El adaptador Bluetooth ASUS USB-BT400 funciona correctamente con Kali.
