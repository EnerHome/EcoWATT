# EcoWatt — proyecto web inicial

Interfaz responsive para una plataforma de inteligencia energética para hogares peruanos. Incluye una portada inspirada en tu referencia visual (fondo verde oscuro, acentos lima, casa energética y tarjetas flotantes) y un panel modular.

## Cómo ejecutarlo en VS Code

1. Descarga y descomprime `EcoWatt.zip`.
2. Abre VS Code → **Archivo → Abrir carpeta…** → selecciona la carpeta `EcoWatt`.
3. Instala la extensión **Live Server** (Ritwick Deyl), si no la tienes.
4. Haz clic derecho en `index.html` → **Open with Live Server**.
5. Se abrirá la web en tu navegador. También puedes abrir `index.html` directamente, aunque Live Server es preferible.

No requiere `npm install` ni compilación. Chart.js y las fuentes tipográficas se cargan desde CDN; los gráficos y fuentes externas necesitan internet.

## Qué incluye

- Portada de EcoWatt y navegación responsive.
- Panel principal con indicadores, gráfico y últimos recibos.
- Registro, edición y eliminación de consumos.
- Historial y gráficos de consumo/costo.
- Comparación de dos periodos en kWh, soles y porcentaje.
- Metas de ahorro y avance.
- Estimador de consumo por electrodoméstico.
- Simulador solar simplificado y editable.
- Recomendaciones y asistente demostrativo basado en reglas.
- Configuración de hogar, tarifa y ciudad.
- Exportación de registros a CSV.
- Ayuda, límites de estimaciones y privacidad.
- Persistencia de los datos en `localStorage`.

## Importante: qué es y qué no es esta versión

Esta es una **demo frontend funcional**, no un producto listo para producción. El registro/inicio de sesión es solo una simulación visual; no protege cuentas. Los datos se guardan en el navegador actual. No incluye todavía Supabase, OCR real, API de IA, datos solares externos, mapas reales, pronóstico entrenado ni sensores ESP32.

Antes de publicar para usuarios reales, integra Supabase Auth y PostgreSQL, activa Row Level Security (RLS), valida los datos en servidor, usa HTTPS y protege las claves de cualquier servicio externo. No pongas claves secretas en los archivos JavaScript del navegador.

## Estructura

```text
EcoWatt/
├── index.html
├── README.md
├── css/
│   └── styles.css
├── js/
│   └── app.js
└── sql/
    └── schema-inicial.sql
```

## Fórmulas usadas en la demo

- **Costo energético estimado:** consumo en kWh × tarifa configurada en S/kWh.
- **Variación porcentual:** (consumo nuevo − consumo anterior) / consumo anterior × 100. Si el anterior es cero, no se calcula.
- **Consumo estimado de un aparato:** potencia en W / 1000 × horas al día × días al mes.
- **Generación solar simplificada:** potencia instalada en kWp × horas solares pico al día × días × rendimiento del sistema.

El importe total del recibo puede diferir del costo energético estimado por cargos fijos, impuestos, bloques tarifarios y otros conceptos. El simulador solar es ilustrativo y no reemplaza un estudio técnico.

## Siguientes pasos recomendados

1. Conectar autenticación y base de datos reales.
2. Separar los datos por usuario/hogar mediante RLS.
3. Añadir carga privada de fotos/PDF y OCR con confirmación manual.
4. Integrar una fuente solar con cobertura comprobada para la ubicación elegida.
5. Crear un backend para IA y predicciones, mostrando fuente, supuestos y confianza.
6. Incorporar sensores/ESP32 solo después de definir un protocolo autenticado y validar las mediciones.

## Actualización visual y geolocalización

- La portada utiliza `assets/eco-lightbulb-plant.png` como fondo visual de ahorro energético.
- El asistente flotante Eco tiene animación CSS, mensajes contextuales y lectura de voz opcional con la función de voz del navegador.
- El módulo **Ubicación en vivo** usa la API de geolocalización del navegador y Leaflet con mosaicos de OpenStreetMap.
- Pulsa **Obtener ubicación** para una lectura puntual o **Seguimiento en vivo** para actualizar el marcador mientras el navegador reciba nuevas coordenadas. Usa **Detener** para finalizar el seguimiento.
- El navegador debe conceder permiso explícito. La geolocalización requiere un contexto seguro: HTTPS o `localhost`; por eso se recomienda ejecutar mediante Live Server.
- Si no se concede el permiso, puedes guardar manualmente la ciudad o distrito.
- La ubicación no mide el consumo eléctrico. Solo ayuda a contextualizar el análisis; los cálculos de consumo usan los recibos ingresados.
- La aplicación demo no transmite las coordenadas a un backend. La carga de mapas requiere conexión a internet y depende de los servicios de mapas externos.

### Ejecutar

1. Descomprime `EcoWatt-Actualizado.zip`.
2. Abre la carpeta `EcoWatt` en Visual Studio Code.
3. Inicia `index.html` con la extensión Live Server.
4. En el panel, abre **Ubicación en vivo** y elige si quieres obtener una ubicación puntual o activar el seguimiento.
